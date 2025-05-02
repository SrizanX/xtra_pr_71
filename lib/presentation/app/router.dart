import 'package:go_router/go_router.dart';
import '../home/home_route.dart';
import '../login/login_route.dart';
import '../settings/settings_route.dart';
import '../sms/sms_route.dart';
import '../splash/splash_route.dart';

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
