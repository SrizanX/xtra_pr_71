import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xtra_pr_71/presentation_v2/app/router.dart';

import '../../design/color_seleection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        scaffoldBackgroundColor: ColorSelection.darkBlue.color,
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: ColorSelection.blue_500.color,
            onPrimary: ColorSelection.white.color,
            secondary: Colors.greenAccent,
            onSecondary: Colors.black12,
            error: Colors.red,
            onError: Colors.black12,
            surface: ColorSelection.darkBlueTransparent.color,
            onSurface: ColorSelection.white.color,
            secondaryContainer: ColorSelection.darkBlue.color),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorSelection.darkBlue.color,
          foregroundColor: ColorSelection.white.color,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ));
    ColorSelection colorSelected = ColorSelection.deepOrange;
    return MaterialApp.router(
      routerConfig: router,
      title: 'XTRA PR71',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('bn'), // Bengali
      ],
      theme: theme,
    );
  }
}
