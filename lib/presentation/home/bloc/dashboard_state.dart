import '../../../domain/entity/device_info.dart';

sealed class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardFailed extends DashboardState {
  final String errorMessage;

  DashboardFailed({required this.errorMessage});
}

/// Live reachability of the router behind the (possibly stale) dashboard data.
///
/// The dashboard keeps showing the last good snapshot on a failed poll so it
/// doesn't flicker, but the indicator must still tell the truth: a router that
/// is rebooting, powered off or simply unreachable is *not* "online".
enum DashboardConnectivity {
  /// Last poll succeeded — data is fresh.
  online,

  /// Polls are failing unexpectedly; showing the last known data.
  reconnecting,

  /// The user triggered a reboot / factory reset / filter change that restarts
  /// the router — expect a short outage, then automatic recovery.
  restarting,

  /// The user powered the router off; it won't return without physical access.
  poweredOff,
}

class DashboardSuccessful extends DashboardState {
  final DeviceInfo deviceInfo;
  final DashboardConnectivity connectivity;

  DashboardSuccessful({
    required this.deviceInfo,
    this.connectivity = DashboardConnectivity.online,
  });
}
