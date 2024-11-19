import 'dart:convert';

import 'package:xtra_pr_71/data/network/mapper/internet_allowance_api_mapper.dart';
import 'package:xtra_pr_71/data/network/mapper/state_response_mapper.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/internet/internet_allowance.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation/home/internet/allowance/allowance_card.dart';

import '../mapper/base/result_mapper.dart';
import '../model/state_response.dart';

class InternetAllowanceApiService {
  Future<Result<InternetAllowanceEntity>> fetchDataUsage() async {
    const url = "http://192.168.0.1/jsonp_datausagestatus?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: AllowanceApiMapper());
  }

  Future<Result<StateResponse>> updateInternetAllowance(
      {required bool isUsageLimitEnabled,
      required num allowance,
      required AllowanceUnit allowanceUnit}) async {
    final param = {
      "dataLimit": isUsageLimitEnabled,
      "settingData": allowance * allowanceUnit.multiplier,
    };

    const url = "http://192.168.0.1/datausage";
    final result = await NetworkClient().get(Uri.parse(url)
        .replace(queryParameters: {'datausageparam': jsonEncode(param)}));

    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
