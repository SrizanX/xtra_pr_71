import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/data/network/api/login_api_service.dart';
import 'package:xtra_pr_71/data/network/model/state_response.dart';
import 'package:xtra_pr_71/data/shared_preferences/prefs_repository.dart';
import 'package:xtra_pr_71/domain/result.dart';
import 'package:xtra_pr_71/presentation_v2/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial()) {
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    if (PrefsRepository().isRememberMeEnabled) {
      final result = await LoginApiService().callLoginAPi(
        username: PrefsRepository().username,
        password: PrefsRepository().password,
      );

      switch (result) {
        case Successful<StateResponse>():
          emit(const SplashState.loginSuccessful());
          break;
        case Failed<StateResponse>():
          emit(SplashState.loginFailed(message: result.message));
          break;
      }
    } else {
      emit(const SplashState.loginFailed(message: "Not remembered"));
    }
  }
}
