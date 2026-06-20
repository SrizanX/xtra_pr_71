import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/device/connected_device.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/connected_devices_api_mapper.dart';
import 'api_config.dart';

class DeviceManagementApiService {
  Future<Result<List<ConnectedDevice>>> fetchConnectedDevices() async {
    if (DemoMode.enabled) return Successful(data: DemoData.connectedDevices);
    const url = "${ApiConfig.baseUrl}/jsonp_device_management_all?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper()
        .map(result: result, mapper: ConnectedDevicesApiMapper());
  }
}
