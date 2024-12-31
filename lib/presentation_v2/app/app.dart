import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/app/route_generator.dart';
import 'package:xtra_pr_71/presentation_v2/splash/splash_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../design/color_seleection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
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
    );
    ColorSelection colorSelected = ColorSelection.deepOrange;
    return MaterialApp(
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
      initialRoute: SplashRoute.route,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
