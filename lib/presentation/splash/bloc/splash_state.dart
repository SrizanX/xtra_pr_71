import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.initial() = Initial;
  const factory SplashState.loginSuccessful() = LoginSuccessfulFromSplash;
  const factory SplashState.loginFailed({required String message}) = LoginFailedFromSplash;
}
