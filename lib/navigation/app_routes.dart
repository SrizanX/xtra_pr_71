import 'package:xtra_pr_71/presentation/home/home_screen.dart';

import '../presentation/login/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
}

var routesMap = {
  AppRoutes.login: (context) => const LoginScreen(),
  AppRoutes.home: (context) => const HomeScreen(),
};
