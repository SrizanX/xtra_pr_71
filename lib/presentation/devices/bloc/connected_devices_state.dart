import '../../../domain/entity/device/connected_device.dart';

sealed class ConnectedDevicesState {}

class ConnectedDevicesLoading extends ConnectedDevicesState {}

class ConnectedDevicesFailed extends ConnectedDevicesState {
  final String errorMessage;

  ConnectedDevicesFailed({required this.errorMessage});
}

class ConnectedDevicesSuccessful extends ConnectedDevicesState {
  final List<ConnectedDevice> devices;

  ConnectedDevicesSuccessful({required this.devices});
}
