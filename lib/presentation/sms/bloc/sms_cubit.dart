import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/domain/entity/sms/sms.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation/sms/bloc/sms_state.dart';
import '../../../data/network/api/sms_api_service.dart';

class SmsCubit extends Cubit<SmsState> {
  SmsCubit() : super(const SmsState.initial()) {
    fetchSms(1);
  }

  void fetchSms(int page) async {
    emit(SmsState.initial());
    var result = await SmsApiService().fetchSms(page);

    switch (result) {
      case Successful<SmsApiEntity>():
        emit(SmsState.smsListSuccessful(sms: result.data));
      case Failed<SmsApiEntity>():
        emit(SmsState.smsListFailed());
    }
  }
}
