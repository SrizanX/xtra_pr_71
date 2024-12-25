import 'package:xtra_pr_71/data/network/mapper/sms_list_response_mapper.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';

import '../../../domain/result.dart';
import '../mapper/base/result_mapper.dart';
import '../network_client.dart';

class SmsApiService {
  Future<Result<SmsApiEntity>> fetchSms(int page) async {
    var url = "http://192.168.0.1/PageList?pageIndex=$page";
    final result = await NetworkClient().get(Uri.parse(url));

    return ResultMapper()
        .map(result: result, mapper: SmsListResponseMapper());
  }
}
