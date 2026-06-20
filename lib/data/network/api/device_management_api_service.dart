import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/device/connected_device.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../mapper/base/result_mapper.dart';
import '../mapper/connected_devices_api_mapper.dart';
import 'api_config.dart';

class DeviceManagementApiService {
  Future<Result<List<ConnectedDevice>>> fetchConnectedDevices() async {
    const url = "${ApiConfig.baseUrl}/jsonp_device_management_all?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper()
        .map(result: result, mapper: ConnectedDevicesApiMapper());
  }
}
