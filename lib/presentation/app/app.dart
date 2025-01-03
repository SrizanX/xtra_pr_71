import 'package:flutter/material.dart';
import 'package:xtra_pr_71/navigation/app_routes.dart';

import '../../design/color_seleection.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    ColorSelection colorSelected = ColorSelection.deepOrange;
    return MaterialApp(
      title: 'XTRA PR71',
      theme: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: colorSelected.color),
      ),
      darkTheme: theme.copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: colorSelected.color),
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      routes: routesMap,
      initialRoute: AppRoutes.login,
      debugShowCheckedModeBanner: false,
    );
  }
}
