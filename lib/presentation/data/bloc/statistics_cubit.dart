import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/statistics_api_service.dart';
import '../../../data/shared_preferences/prefs_repository.dart';
import '../../../domain/entity/statistics/usage_statistics.dart';
import '../../../domain/result.dart';
import 'statistics_state.dart';

/// Polls `jsonp_statistics` to drive the live speed meter. The interval is
/// configured in Settings ([PrefsRepository.speedRefreshMs]); `0` pauses
/// polling. Each cycle fetches, then schedules the next one, so slow responses
/// can't stack up — and the loop resumes automatically when the user changes
/// the interval (including Off → On).
class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit({PrefsRepository? prefs})
      : _interval = (prefs ?? PrefsRepository()).speedRefreshMs,
        super(StatisticsLoading()) {
    _interval.addListener(_onIntervalChanged);
    _loop();
  }

  final ValueNotifier<int> _interval;
  Timer? _timer;
  bool _inFlight = false;

  /// Consecutive failed polls; drives back-off so an unreachable router isn't
  /// polled every second. Reset on the first success.
  int _failures = 0;

  /// Back-off ceiling while the router is unreachable. Kept small so recovery
  /// after the router/Wi-Fi comes back stays prompt: the effective interval is
  /// clamped to `[base, max(base, _maxBackoffMs)]`, so only a sub-5s meter rate
  /// is throttled (up to this ceiling) and anything slower never backs off.
  static const int _maxBackoffMs = 5000;

  void _onIntervalChanged() {
    // Restart the cadence with the new interval (and resume if it was Off).
    _timer?.cancel();
    _loop();
  }

  Future<void> _loop() async {
    await fetchStatistics();
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final base = _interval.value;
    if (base <= 0) return; // paused
    _timer = Timer(Duration(milliseconds: _backoffMs(base)), _loop);
  }

  /// Normal cadence when healthy; mild back-off once polls fail, never slower
  /// than [base] nor than [_maxBackoffMs]. Resets to [base] on the first success.
  int _backoffMs(int base) {
    if (_failures == 0) return base;
    final cap = base > _maxBackoffMs ? base : _maxBackoffMs;
    final ms = base * (1 << _failures.clamp(1, 5)); // ×2 … ×32
    return ms > cap ? cap : ms;
  }

  /// Resets the router's traffic counters, then refreshes. Returns whether the
  /// reset request succeeded.
  Future<bool> clearTraffic() async {
    final result = await StatisticsApiService().clearTraffic();
    if (isClosed) return false;
    final ok = result is Successful<String>;
    if (ok) fetchStatistics();
    return ok;
  }

  Future<void> fetchStatistics() async {
    if (_inFlight) return;
    _inFlight = true;
    final result = await StatisticsApiService().fetchStatistics();
    _inFlight = false;
    if (isClosed) return;
    switch (result) {
      case Successful<UsageStatistics>():
        _failures = 0;
        emit(StatisticsSuccessful(statistics: result.data));
      case Failed<UsageStatistics>():
        _failures++;
        // Keep the last good reading visible during transient poll failures;
        // only surface the error if we never loaded anything.
        if (state is! StatisticsSuccessful) {
          emit(StatisticsFailed(errorMessage: result.message));
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
