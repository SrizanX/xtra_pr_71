import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xtra_pr_71/presentation/app/router.dart';
import 'package:xtra_pr_71/presentation/app/theme.dart';

import '../../l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: kDebugMode,
      builder: (_) => MaterialApp.router(
        useInheritedMediaQuery: true,
        routerConfig: router,
        title: 'XTRA PR71',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('bn'), // Bengali
        ],
        theme: theme,
      ),
    );
  }
}
