import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/demo/demo_mode.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/data/shared_preferences/prefs_repository.dart';
import 'package:xtra_pr_71/domain/result.dart';
import '../../../data/network/api/login_api_service.dart';
import 'login_state.dart';

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
    // Ignore re-entrant taps while a request is already in flight.
    if (state.loginApiState is LoginInProgress) return;

    // The built-in demo account opens the app with sample data instead of
    // contacting a router (used by reviewers / for trying the app without one).
    if (DemoMode.matches(state.username, state.password)) {
      DemoMode.enabled = true;
      if (state.isStaySignedInChecked) saveCredentials();
      emit(state.copyWith(
          loginApiState: const LoginApiState.loginSuccessful()));
      return;
    }

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
