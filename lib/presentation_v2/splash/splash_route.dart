import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation_v2/splash/bloc/splash_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/splash/splash_screen.dart';

class SplashRoute {
  static const String route = "/splash";

  static Route generate() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => SplashCubit(),
        child: const SplashScreen(),
      ),
    );
  }

  static generateGoRoute() {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    );
  }
}
