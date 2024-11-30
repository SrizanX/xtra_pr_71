import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/login/login_screen.dart';

class LoginRoute {
  static const String route = "/login";

  static Route generate() {
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }
}
