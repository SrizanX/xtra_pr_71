import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/api/login_api_service.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/domain/result.dart';

sealed class LoginUiState {}

sealed class LoginUiEvent {}

class Login extends LoginUiEvent {
  final String username;
  final String password;

  Login(this.username, this.password);
}

class Retry extends LoginUiEvent {}

class Loading extends LoginUiState {}

class LoginSuccessful extends LoginUiState {}

class LoginFailed extends LoginUiState {
  String message;

  LoginFailed({required this.message});
}

class Initial extends LoginUiState {}

class LoginBloc extends Bloc<LoginUiEvent, LoginUiState> {
  LoginBloc(super.initialState) {
    on<LoginUiEvent>(_handleEvents);
  }

  void _handleEvents(LoginUiEvent event, Emitter<LoginUiState> emit) async {
    switch (event) {
      case Login():
        emit(Loading());
        final responseCode = await LoginApiService().callLoginAPi(
          username: event.username,
          password: event.password,
        );

        switch (responseCode) {
          case Successful<StateResponse>():
            emit(LoginSuccessful());
          case Failed<StateResponse>():
            emit(Initial());
            emit(LoginFailed(message: responseCode.message));
        }

      case Retry():
      // TODO: Handle this case.
    }
  }
}
