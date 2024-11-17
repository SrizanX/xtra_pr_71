import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/api/login_api_service.dart';

@immutable
sealed class ConnectionStatusState {}

final class Connected extends ConnectionStatusState {}

final class Disconnected extends ConnectionStatusState {}

class ConnectionStatusCubit extends Cubit<ConnectionStatusState> {
  ConnectionStatusCubit() : super(Disconnected()) {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final responseCode = await LoginApiService().callLoginAPi(
        username: "",
        password: "",
      );
      if (responseCode == 0 || responseCode == 1) {
        emit(Connected());
      } else {
        emit(Disconnected());
      }
    });
  }
}
