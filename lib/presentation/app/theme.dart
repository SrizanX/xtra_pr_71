import 'package:flutter/material.dart';

import '../../design/color_seleection.dart';

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
