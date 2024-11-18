import 'package:xtra_pr_71/data/network/mapper/internet_allowance_api_mapper.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/internet/internet_allowance.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../mapper/base/result_mapper.dart';

class InternetAllowanceApiService {
  Future<Result<InternetAllowanceEntity>> fetchDataUsage() async {
    const url = "http://192.168.0.1/jsonp_datausagestatus?callback=";
    final response = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(response: response, mapper: AllowanceApiMapper());
  }
}
