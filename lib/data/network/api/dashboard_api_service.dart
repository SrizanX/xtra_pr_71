import 'package:xtra_pr_71/data/network/mapper/base/result_mapper.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/entity/device_info.dart';
import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/dashboard_api_mapper.dart';
import 'api_config.dart';

class DashboardApiService {
  Future<Result<DeviceInfo>> fetchDashboardData() async {
    if (DemoMode.enabled) return Successful(data: DemoData.deviceInfo);
    const url = "${ApiConfig.baseUrl}/jsonp_dashboard?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: DashboardApiMapper());
  }
}
