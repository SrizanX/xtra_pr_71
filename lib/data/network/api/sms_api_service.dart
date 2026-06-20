import 'dart:convert';

import 'package:xtra_pr_71/data/network/mapper/sms_list_response_mapper.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';

import '../../../domain/result.dart';
import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/state_response_mapper.dart';
import '../model/state_response.dart';
import '../network_client.dart';
import 'api_config.dart';

class SmsApiService {
  Future<Result<SmsApiEntity>> fetchSms(int page) async {
    if (DemoMode.enabled) return Successful(data: DemoData.sms);
    var url = "${ApiConfig.baseUrl}/PageList?pageIndex=$page";
    final result = await NetworkClient().get(Uri.parse(url));

    return ResultMapper()
        .map(result: result, mapper: SmsListResponseMapper());
  }

  /// Deletes the given messages via `DeleteList`. Each entry is identified by
  /// its `messageid` and the page it lives on (`curpage`).
  Future<Result<StateResponse>> deleteMessages(List<Sms> messages) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final param = [
      for (final m in messages) {"id": m.messageid, "curpage": m.page},
    ];
    const url = "${ApiConfig.baseUrl}/DeleteList";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"deleList": jsonEncode(param)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }
}
