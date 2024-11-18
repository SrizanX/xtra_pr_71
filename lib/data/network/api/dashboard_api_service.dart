import 'package:xtra_pr_71/data/network/mapper/base/result_mapper.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/entity/device_info.dart';
import '../mapper/dashboard_api_mapper.dart';

class DashboardApiService {
  Future<Result<DeviceInfo>> fetchDashboardData() async {
    const url = "http://192.168.0.1/jsonp_dashboard?callback=";
    final response = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(response: response, mapper: DashboardApiMapper());
  }
}
