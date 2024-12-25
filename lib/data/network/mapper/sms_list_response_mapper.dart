import 'dart:convert';

import 'package:xtra_pr_71/domain/entity/sms/sms.dart';

import '../../../domain/type.dart';
import 'base/mapper.dart';

class SmsListResponseMapper extends Mapper<dynamic, SmsApiEntity> {
  @override
  SmsApiEntity map(input) {
    return SmsApiEntity.fromJson(jsonDecode(input) as JMap);
  }
}
