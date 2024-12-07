import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default("admin") String username,
    @Default("admin") String password,
    @Default(false) bool isStaySignedInChecked,
    @Default(LoginApiState.initial()) LoginApiState loginApiState,
  }) = _LoginState;
}

@freezed
class LoginApiState with _$LoginApiState {
  const factory LoginApiState.initial() = Initial;

  const factory LoginApiState.loginInProgress() = LoginInProgress;

  const factory LoginApiState.loginSuccessful() = LoginSuccessful;

  const factory LoginApiState.loginFailed({required String message}) =
      LoginFailed;
}
