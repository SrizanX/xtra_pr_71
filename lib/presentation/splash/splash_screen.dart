import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../design/design_system.dart';
import '../home/home_route.dart';
import '../login/login_route.dart';
import 'bloc/splash_cubit.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blue = AppColors.blue500;
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is LoginSuccessfulFromSplash) {
            context.go(HomeRoute.route);
          } else if (state is LoginFailedFromSplash) {
            context.go(LoginRoute.route);
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      blue.withValues(alpha: 0.28),
                      blue.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: blue.withValues(alpha: 0.35)),
                  boxShadow: [
                    BoxShadow(
                      color: blue.withValues(alpha: 0.35),
                      blurRadius: 32,
                      spreadRadius: -6,
                    ),
                  ],
                ),
                child: Icon(Icons.router, size: 56, color: blue),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'XTRA PR71',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
