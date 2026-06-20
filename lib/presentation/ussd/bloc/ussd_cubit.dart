import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/api/ussd_api_service.dart';
import '../../../data/network/model/state_response.dart';
import '../../../domain/result.dart';
import 'ussd_state.dart';

class UssdCubit extends Cubit<UssdState> {
  UssdCubit() : super(UssdIdle());

  final _service = UssdApiService();

  /// Delay between submitting a code and reading the response, per the router's
  /// "wait 3–5 seconds then call ussdback" mechanism.
  static const _responseDelay = Duration(seconds: 4);

  Future<void> dial(String code) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return;

    emit(UssdInProgress(status: 'Dialing $trimmed…'));
    final sent = await _service.sendUssd(trimmed);
    switch (sent) {
      case Successful<StateResponse>():
        if (sent.data.state != 1) {
          emit(UssdFailure(message: 'The router rejected the code.'));
          return;
        }
        emit(UssdInProgress(status: 'Waiting for response…'));
        await Future.delayed(_responseDelay);
        final back = await _service.fetchUssdResponse();
        switch (back) {
          case Successful<String>():
            emit(UssdSuccess(response: back.data));
          case Failed<String>():
            emit(UssdFailure(message: back.message));
        }
      case Failed<StateResponse>():
        emit(UssdFailure(message: sent.message));
    }
  }

  void reset() => emit(UssdIdle());
}
