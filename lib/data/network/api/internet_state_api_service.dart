import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/entity/internet/network_info.dart';
import '../../../domain/type.dart';
import '../../../presentation/home/internet/network_mode.dart';
import '../network_client.dart';

class InternetStateApiService {
  Future<Result<NetworkInfo>> getInternetState() async {
    const url = "http://192.168.0.1/jsonp_internetconn?callback=";

    var client = NetworkClient();
    var loginResult = await client.get(Uri.parse(url));

    switch (loginResult) {
      case Successful():
        var xmlParser = Xml2Json();
        xmlParser.parse(loginResult.data);
        final decoded = jsonDecode(xmlParser.toOpenRally()) as JMap;
        return Successful(data: NetworkInfo.fromJson(decoded['blog']));
      case Failed():
        return Failed(message: loginResult.message);
    }
  }

  Future<Result<StateResponse>> updateInternetState({
    required NetworkMode networkMode,
    required bool isMobileDataEnabled,
    required bool isRoamingEnabled,
  }) async {
    final param = {
      "type": networkMode.value,
      "roaming": isRoamingEnabled ? 1 : 0,
      "isdataopen": isMobileDataEnabled ? 1 : 0,
    };

    const url = "http://192.168.0.1/postnetwork";
    final uri = Uri.parse(url)
        .replace(queryParameters: {'postnetwork': jsonEncode(param)});

    /** have to make it  reusable */
    var client = NetworkClient();
    final response = await client.get(uri);

    switch (response) {
      case Successful():
        var state = StateResponse.fromJson(jsonDecode(response.data));
        return Successful(data: state);
      case Failed():
        return Failed(message: response.message);
    }
  }
}
