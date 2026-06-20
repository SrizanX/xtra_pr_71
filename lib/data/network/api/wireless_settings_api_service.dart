import 'dart:convert';

import 'package:xtra_pr_71/data/network/mapper/base/result_mapper.dart';
import 'package:xtra_pr_71/data/network/mapper/state_response_mapper.dart';
import 'package:xtra_pr_71/data/network/mapper/wireless_settings_api_mapper.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/entity/wireless/wireless_info.dart';
import '../network_client.dart';
import 'api_config.dart';

class WirelessSettingsApiService {
  Future<Result<WirelessInfo>> fetchWirelessSettings() async {
    const url =
        "${ApiConfig.baseUrl}/jsonp_uapxb_wlan_security_settings?callback=";
    final result = await NetworkClient().get(Uri.parse(url));

    return ResultMapper()
        .map(result: result, mapper: WirelessSettingApiMapper());
  }

  Future<Result<StateResponse>> updateWirelessSettings({
    required String wifiName,
    required String password,
    required double maxDeviceCount,
    int hideWifi = 0,
  }) async {
    final param = {
      "username": wifiName,
      "password": password,
      "maxcount": "$maxDeviceCount",
      "iswifihot": "1",
      "wifitype": 4,
      "bandtype": 0,
      "isHide": hideWifi,
      "isClose": 1,
    };

    const url = "${ApiConfig.baseUrl}/changeWifi";
    final result = await NetworkClient().get(Uri.parse(url)
        .replace(queryParameters: {'wifiparam': jsonEncode(param)}));
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
