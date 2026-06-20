import 'dart:convert';

import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/type.dart';
import '../model/state_response.dart';
import 'api_config.dart';

/// Two-step USSD over the router:
/// 1. [sendUssd] submits the code and returns `{"state": 1}` on acceptance.
/// 2. After a short wait, [fetchUssdResponse] returns `{"state": "<text>"}`
///    with the network's reply.
class UssdApiService {
  Future<Result<StateResponse>> sendUssd(String code) async {
    final param = {"ussdnumber": code};
    final uri = Uri.parse("${ApiConfig.baseUrl}/ussd?callback=")
        .replace(queryParameters: {'ussdparam': jsonEncode(param)});

    final response = await NetworkClient().get(uri);
    switch (response) {
      case Successful():
        return Successful(data: StateResponse.fromJson(jsonDecode(response.data)));
      case Failed():
        return Failed(message: response.message);
    }
  }

  Future<Result<String>> fetchUssdResponse() async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/ussdback?callback=");

    final response = await NetworkClient().get(uri);
    switch (response) {
      case Successful():
        final decoded = jsonDecode(response.data) as JMap;
        return Successful(data: '${decoded['state'] ?? ''}');
      case Failed():
        return Failed(message: response.message);
    }
  }
}
