import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/statistics/usage_statistics.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../mapper/base/result_mapper.dart';
import '../mapper/statistics_api_mapper.dart';
import 'api_config.dart';

class StatisticsApiService {
  Future<Result<UsageStatistics>> fetchStatistics() async {
    const url = "${ApiConfig.baseUrl}/jsonp_statistics?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: StatisticsApiMapper());
  }
}
