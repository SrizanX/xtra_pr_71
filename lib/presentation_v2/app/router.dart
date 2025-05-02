import 'package:go_router/go_router.dart';
import 'package:xtra_pr_71/presentation_v2/login/login_route.dart';
import 'package:xtra_pr_71/presentation_v2/settings/settings_route.dart';
import 'package:xtra_pr_71/presentation_v2/splash/splash_route.dart';

import '../home/home_route.dart';
import '../sms/sms_route.dart';

final router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashRoute.generateGoRoute();
      }),
  LoginRoute.generateGoRoute(),
  HomeRoute.generateGoRoute(),
  SmsRoute.generateGoRoute(),
  SettingsRoute.generateGoRoute()
]);
