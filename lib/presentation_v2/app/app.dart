import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/app/route_generator.dart';

import '../../design/color_seleection.dart';

class App extends StatelessWidget {
  const App({super.key});

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
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
