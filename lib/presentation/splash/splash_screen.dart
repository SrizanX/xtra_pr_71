import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../home/home_route.dart';
import '../login/login_route.dart';
import 'bloc/splash_cubit.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SplashCubit, SplashState>(
          builder: (context, state) => const CircularProgressIndicator(),
          listener: (context, state) {
            if (state is LoginSuccessfulFromSplash) {
              context.go(HomeRoute.route);
            } else if (state is LoginFailedFromSplash) {
              context.go(LoginRoute.route);
            }
          },
        ),
      ),
    );
  }
}
