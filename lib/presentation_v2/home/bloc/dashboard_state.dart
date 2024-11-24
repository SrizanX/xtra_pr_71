import '../../../domain/entity/device_info.dart';

sealed class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardFailed extends DashboardState {
  final String errorMessage;

  DashboardFailed({required this.errorMessage});
}

class DashboardSuccessful extends DashboardState {
  final DeviceInfo deviceInfo;

  DashboardSuccessful({required this.deviceInfo});
}
