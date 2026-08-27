import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/sms_api_service.dart';
import '../../../data/network/model/state_response.dart';
import '../../../domain/result.dart';
import 'send_sms_state.dart';

/// Drives the router's two-step SMS send, the same shape as [UssdCubit]:
/// submit the message, wait for the router to actually push it, then confirm.
class SendSmsCubit extends Cubit<SendSmsState> {
  SendSmsCubit() : super(SendSmsIdle());

  final _service = SmsApiService();

  /// Delay between submitting and reading the outcome, per the router's
  /// "send, then a few seconds later call messageback" mechanism.
  static const _confirmDelay = Duration(seconds: 4);

  bool get isSending => state is SendSmsInProgress;

  Future<void> send(String number, String content) async {
    final to = number.trim();
    final body = content.trim();
    if (to.isEmpty || body.isEmpty || isSending) return;

    emit(SendSmsInProgress(status: 'Sending…'));
    final sent = await _service.sendSms(to, body);
    if (isClosed) return;
    switch (sent) {
      case Successful<StateResponse>():
        if (sent.data.state != 1) {
          emit(SendSmsFailure(message: 'The router rejected the message.'));
          return;
        }
        emit(SendSmsInProgress(status: 'Confirming delivery…'));
        await Future.delayed(_confirmDelay);
        if (isClosed) return;
        final back = await _service.checkSentMessage();
        if (isClosed) return;
        switch (back) {
          case Successful<StateResponse>():
            if (back.data.state == 1) {
              emit(SendSmsSuccess(number: to, content: body));
            } else {
              emit(SendSmsFailure(message: 'Message could not be delivered.'));
            }
          case Failed<StateResponse>():
            emit(SendSmsFailure(message: back.message));
        }
      case Failed<StateResponse>():
        emit(SendSmsFailure(message: sent.message));
    }
  }

  /// Returns to idle after the UI has consumed a success/failure.
  void reset() => emit(SendSmsIdle());
}
