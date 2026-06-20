import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xtra_pr_71/design/app_typography.dart';
import 'package:xtra_pr_71/presentation/app/router.dart';
import 'package:xtra_pr_71/presentation/app/theme.dart';

import '../../l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: kDebugMode,
      // `previewContext` is below the DevicePreview widget, so DevicePreview
      // lookups (locale/store) resolve — the outer App context would not.
      builder: (previewContext) => MaterialApp.router(
        // Required by device_preview 1.3.1 (it asserts on this at runtime),
        // even though Flutter now marks it deprecated/ignored.
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(previewContext),
        routerConfig: router,
        // Run Device Preview's appBuilder so the simulated device's MediaQuery
        // (size, padding, text scale) is what the app reads — otherwise every
        // screen sees the host window and a phone renders as a tablet. The
        // text-scale clamp sits inside it so it resolves against the device.
        builder: (context, child) => DevicePreview.appBuilder(
          context,
          MediaQuery.withClampedTextScaling(
            minScaleFactor: AppTypography.minTextScale,
            maxScaleFactor: AppTypography.maxTextScale,
            child: child!,
          ),
        ),
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
