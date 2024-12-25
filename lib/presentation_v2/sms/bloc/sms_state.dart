import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';

part 'sms_state.freezed.dart';

@freezed
sealed class SmsState with _$SmsState {
  const factory SmsState.initial() = Initial;

  const factory SmsState.smsListSuccessful({required SmsApiEntity sms}) = SmsListSuccessful;

  const factory SmsState.smsListFailed() = SmsListFailed;
}
