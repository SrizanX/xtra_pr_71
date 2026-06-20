import 'dart:convert';

import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/apn/apn_settings.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/apn_settings_api_mapper.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/state_response_mapper.dart';
import '../model/state_response.dart';
import 'api_config.dart';

class ApnApiService {
  Future<Result<ApnSettings>> fetchApnSettings() async {
    if (DemoMode.enabled) return Successful(data: DemoData.apn);
    const url = "${ApiConfig.baseUrl}/jsonp_pin_apn_setting?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: ApnSettingsApiMapper());
  }

  /// Writes the APN via `postApnList`. The firmware's field names are quirky:
  /// MNC goes as `Apnmnc`, the protocol as `mApnrp`, the roaming protocol as
  /// `apnroamtype`, and blank text fields are sent as "None" (ports as "0"),
  /// mirroring the router's own web UI.
  Future<Result<StateResponse>> updateApn(ApnSettings apn) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    String s(String v) => v.trim().isEmpty ? 'None' : v.trim();
    String n(String v) => v.trim().isEmpty ? '0' : v.trim();

    final body = {
      "mApnname": s(apn.name),
      "mApnapn": s(apn.apn),
      "mApnproxy": s(apn.proxy),
      "mApnport": n(apn.port),
      "mApnuser": s(apn.username),
      "mApnpassword": s(apn.password),
      "mApnserver": s(apn.server),
      "mApnmmsc": s(apn.mmsc),
      "mApnmmsproxy": s(apn.mmsProxy),
      "mApnmmsport": n(apn.mmsPort),
      "mApnmcc": s(apn.mcc),
      "Apnmnc": s(apn.mnc),
      "mApnauthtype": apn.authType.index.toString(),
      "mApntype": s(apn.apnType),
      "mApnrp": apn.protocol.label,
      "apnroamtype": apn.roamingProtocol.label,
      "Apnmvnotype": s(apn.mvnoType),
    };

    const url = "${ApiConfig.baseUrl}/postApnList";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"apnList": jsonEncode(body)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
