import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation/app/app.dart';
import 'data/shared_preferences/prefs_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsRepository().init();

  runApp(const App());
}
