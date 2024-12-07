import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/app/route_generator.dart';
import 'package:xtra_pr_71/presentation_v2/splash/splash_route.dart';

import '../../design/color_seleection.dart';

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
        secondaryContainer: ColorSelection.darkBlue.color
      ),
    );
    ColorSelection colorSelected = ColorSelection.deepOrange;
    return MaterialApp(
      title: 'XTRA PR71',
      theme: theme,
      initialRoute: SplashRoute.route,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
