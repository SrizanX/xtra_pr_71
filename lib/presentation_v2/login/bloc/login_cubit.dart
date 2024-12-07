import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/data/shared_preferences/prefs_repository.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation_v2/login/bloc/login_state.dart';

import '../../../data/network/api/login_api_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onUsernameChange(String username) {
    emit(state.copyWith(username: username));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: password));
  }

  void onSaveCredentialCheckBoxChange(bool value) {
    emit(state.copyWith(isStaySignedInChecked: value));
  }

  void login() async {
    emit(state.copyWith(loginApiState: const LoginApiState.loginInProgress()));
    final result = await LoginApiService().callLoginAPi(
      username: state.username,
      password: state.password,
    );

    switch (result) {
      case Successful<StateResponse>():
        if (state.isStaySignedInChecked) saveCredentials();
        emit(state.copyWith(
            loginApiState: const LoginApiState.loginSuccessful()));
        break;
      case Failed<StateResponse>():
        emit(state.copyWith(
            loginApiState: LoginApiState.loginFailed(message: result.message)));
        break;
    }
  }

  void saveCredentials() {
    PrefsRepository().isRememberMeEnabled = state.isStaySignedInChecked;
    PrefsRepository().username = state.username;
    PrefsRepository().password = state.password;
  }
}
