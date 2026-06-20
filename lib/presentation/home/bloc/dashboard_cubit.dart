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

  void _onIntervalChanged() {
    _timer?.cancel();
    _loop();
  }

  Future<void> _loop() async {
    await fetchDashBoardData();
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final ms = _interval.value;
    if (ms <= 0) return; // paused
    _timer = Timer(Duration(milliseconds: ms), _loop);
  }

  Future<void> fetchDashBoardData() async {
    if (_inFlight) return;
    _inFlight = true;
    final result = await DashboardApiService().fetchDashboardData();
    _inFlight = false;
    if (isClosed) return;
    switch (result) {
      case Successful<DeviceInfo>():
        emit(DashboardSuccessful(deviceInfo: result.data));
      case Failed<DeviceInfo>():
        // Only show the error screen if we have nothing to display yet.
        if (state is! DashboardSuccessful) {
          emit(DashboardFailed(errorMessage: result.message));
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
