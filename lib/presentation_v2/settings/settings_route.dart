import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/settings/settings_screen.dart';

class SettingsRoute {
  static const String route = "/settings";

  static Route generate() {
    return MaterialPageRoute(builder: (_) => const SettingsScreen());
  }
}
