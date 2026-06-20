import 'dart:convert';

import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/entity/mac_filter/mac_filter.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/mac_filter_api_mapper.dart';
import '../mapper/state_response_mapper.dart';
import '../model/state_response.dart';
import 'api_config.dart';

class MacFilterApiService {
  Future<Result<MacFilter>> fetchMacFilters() async {
    if (DemoMode.enabled) return Successful(data: DemoData.macFilter);
    const url = "${ApiConfig.baseUrl}/jsonp_macfilterslist?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    return ResultMapper().map(result: result, mapper: MacFilterApiMapper());
  }

  /// Writes the full blocklist (the router expects all 10 slots every time)
  /// plus the mode: `macstatus` 2 = deny listed, 0 = filtering off.
  Future<Result<StateResponse>> applyMacFilter({
    required List<String> macs,
    required bool denyEnabled,
  }) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final param = <Map<String, dynamic>>[
      for (var i = 0; i < MacFilter.maxEntries; i++)
        {"id": i, "mac": i < macs.length ? macs[i] : ""},
      {"macstatus": denyEnabled ? 2 : 0},
    ];

    const url = "${ApiConfig.baseUrl}/wirelessmacfilters";
    final result = await NetworkClient().get(
      Uri.parse(
        url,
      ).replace(queryParameters: {"macfiltersparm": jsonEncode(param)}),
    );

    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
