import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/statistics/usage_statistics.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/statistics_api_mapper.dart';
import 'api_config.dart';

class StatisticsApiService {
  Future<Result<UsageStatistics>> fetchStatistics() async {
    if (DemoMode.enabled) return Successful(data: DemoData.statistics);
    const url = "${ApiConfig.baseUrl}/jsonp_statistics?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: StatisticsApiMapper());
  }

  /// Resets the session traffic counters. Takes no parameters; the response is
  /// the (zeroed) stats rather than a state flag, so a successful HTTP call is
  /// treated as success.
  Future<Result<String>> clearTraffic() async {
    if (DemoMode.enabled) return Successful(data: 'ok');
    const url = "${ApiConfig.baseUrl}/triffic_clear";
    return NetworkClient().get(Uri.parse(url));
  }
}
