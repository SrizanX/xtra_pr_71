import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/home/home_route.dart';

import '../login/login_route.dart';
import '../settings/settings_route.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeRoute.route:
        return HomeRoute.generate();

      case LoginRoute.route:
        return LoginRoute.generate();

      case SettingsRoute.route:
        return SettingsRoute.generate();

      default:
        return MaterialPageRoute(
            builder: (_) => const Text("Route is not defined"));
    }
  }
}
