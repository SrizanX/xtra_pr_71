import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/device_management_api_service.dart';
import '../../../domain/entity/device/connected_device.dart';
import '../../../domain/result.dart';
import 'connected_devices_state.dart';

class ConnectedDevicesCubit extends Cubit<ConnectedDevicesState> {
  ConnectedDevicesCubit() : super(ConnectedDevicesLoading()) {
    fetchConnectedDevices();
  }

  void fetchConnectedDevices() async {
    emit(ConnectedDevicesLoading());
    final result = await DeviceManagementApiService().fetchConnectedDevices();
    switch (result) {
      case Successful<List<ConnectedDevice>>():
        emit(ConnectedDevicesSuccessful(devices: result.data));
      case Failed<List<ConnectedDevice>>():
        emit(ConnectedDevicesFailed(errorMessage: result.message));
    }
  }
}
