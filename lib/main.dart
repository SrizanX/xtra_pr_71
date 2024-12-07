import 'package:flutter/material.dart';

import 'data/shared_preferences/prefs_repository.dart';
import 'presentation_v2/app/app.dart';
//import 'presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsRepository().init();

  runApp(const App());
}
