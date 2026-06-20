import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/entity/device_info.dart';
import 'package:xtra_pr_71/domain/result.dart';
import '../../../data/network/api/dashboard_api_service.dart';
import '../../../data/shared_preferences/prefs_repository.dart';
import 'dashboard_state.dart';

/// Periodically refreshes the home dashboard (battery, signal, devices, …).
/// The interval is configured in Settings ([PrefsRepository.dashboardRefreshMs]);
/// `0` pauses polling. The loading spinner only shows on the very first load —
/// subsequent polls update in place and keep the last good data on a transient
/// failure, so the home screen never flickers back to a spinner/error.
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({PrefsRepository? prefs})
      : _interval = (prefs ?? PrefsRepository()).dashboardRefreshMs,
        super(DashboardLoading()) {
    _interval.addListener(_onIntervalChanged);
    _loop();
  }

  final ValueNotifier<int> _interval;
  Timer? _timer;
  bool _inFlight = false;

  /// Consecutive failed polls. One dropped poll is tolerated (kept "online")
  /// before the indicator switches to "reconnecting", to avoid flicker on a
  /// single blip. Also drives back-off so an unreachable router isn't hammered.
  int _failures = 0;

  /// Back-off ceiling while the router is unreachable. Kept small so recovery
  /// after the router/Wi-Fi comes back is no slower than the configured refresh:
  /// the effective interval is clamped to `[base, max(base, _maxBackoffMs)]`, so
  /// a normal dashboard interval (≥5s) never backs off at all, and only a very
  /// fast interval is throttled — up to this ceiling.
  static const int _maxBackoffMs = 5000;

  void _onIntervalChanged() {
    _timer?.cancel();
    _loop();
  }

  DeviceInfo? get _lastData => state is DashboardSuccessful
      ? (state as DashboardSuccessful).deviceInfo
      : null;

  DashboardConnectivity? get _connectivity => state is DashboardSuccessful
      ? (state as DashboardSuccessful).connectivity
      : null;

  /// Reflect an expected outage immediately, before the next poll fails — the
  /// user just rebooted / factory-reset / applied a filter that restarts the
  /// router. Recovery is automatic once a poll succeeds again.
  void markRestarting() => _markOutage(DashboardConnectivity.restarting);

  /// The router was powered off; it won't come back on its own.
  void markPoweredOff() => _markOutage(DashboardConnectivity.poweredOff);

  void _markOutage(DashboardConnectivity status) {
    final last = _lastData;
    if (last == null) return;
    _failures = 0;
    emit(DashboardSuccessful(deviceInfo: last, connectivity: status));
  }

  Future<void> _loop() async {
    await fetchDashBoardData();
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final base = _interval.value;
    if (base <= 0) return; // paused
    _timer = Timer(Duration(milliseconds: _backoffMs(base)), _loop);
  }

  /// Normal cadence when healthy; mild back-off once polls fail, never slower
  /// than [base] nor than [_maxBackoffMs]. Resets to [base] on the first
  /// success — so reconnecting recovers within one configured interval.
  int _backoffMs(int base) {
    if (_failures == 0) return base;
    final cap = base > _maxBackoffMs ? base : _maxBackoffMs;
    final ms = base * (1 << _failures.clamp(1, 5)); // ×2 … ×32
    return ms > cap ? cap : ms;
  }

  Future<void> fetchDashBoardData() async {
    if (_inFlight) return;
    _inFlight = true;
    final result = await DashboardApiService().fetchDashboardData();
    _inFlight = false;
    if (isClosed) return;
    switch (result) {
      case Successful<DeviceInfo>():
        // A successful poll always means the router is reachable again, which
        // clears any reconnecting / restarting / powered-off status.
        _failures = 0;
        emit(DashboardSuccessful(deviceInfo: result.data));
      case Failed<DeviceInfo>():
        _failures++;
        final last = _lastData;
        if (last == null) {
          // Nothing to show yet — surface the error screen.
          emit(DashboardFailed(errorMessage: result.message));
          return;
        }
        // Keep an explicit user-triggered status (restarting / powered off)
        // rather than downgrading it to a generic "reconnecting".
        if (_connectivity == DashboardConnectivity.restarting ||
            _connectivity == DashboardConnectivity.poweredOff) {
          return;
        }
        // Tolerate a single dropped poll; flag reconnecting from the second.
        if (_failures >= 2 &&
            _connectivity != DashboardConnectivity.reconnecting) {
          emit(DashboardSuccessful(
            deviceInfo: last,
            connectivity: DashboardConnectivity.reconnecting,
          ));
        }
    }
  }

  @override
  Future<void> close() {
    _interval.removeListener(_onIntervalChanged);
    _timer?.cancel();
    return super.close();
  }
}
