import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/home/home_route.dart';

import '../contacts/contacts_route.dart';
import '../login/login_route.dart';
import '../settings/settings_route.dart';
import '../sms/sms_route.dart';
import '../splash/splash_route.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeRoute.route:
        return HomeRoute.generate();

      case LoginRoute.route:
        return LoginRoute.generate();

      case SplashRoute.route:
        return SplashRoute.generate();

      case SettingsRoute.route:
        return SettingsRoute.generate();

      case ContactsRoute.route:
        return ContactsRoute.generate();

      case SmsRoute.route:
        return SmsRoute.generate();

      default:
        return MaterialPageRoute(
            builder: (_) => const Text("Route is not defined"));
    }
  }
}
