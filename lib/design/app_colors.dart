import 'package:flutter/material.dart';

/// Brand and accent palette — the single source of raw color values.
///
/// Prefer the semantic roles on `Theme.of(context).colorScheme` where one fits;
/// reach for these for brand accents, gauges and decorative fills that don't map
/// cleanly onto a Material color role. Opacity variants are applied at the call
/// site with `.withValues(alpha: …)`.
abstract final class AppColors {
  /// Base text / icon color on the app's dark surfaces.
  static const Color white = Colors.white;

  /// Primary brand blue.
  static const Color blue500 = Color(0xff5492f7);

  /// Lighter blue for links and secondary accents.
  static const Color blueLight = Color(0xff8ab4ff);

  /// Green accent — healthy / success / "on" states.
  static const Color greenAccent = Color(0xff43e0a0);

  /// Amber accent — warnings and data-usage emphasis.
  static const Color amber = Color(0xfff5b14c);

  /// Red accent — danger zones (e.g. the top of a speed gauge).
  static const Color danger = Color(0xffff5a5a);

  /// App background and card surface (dark navy).
  static const Color darkBlue = Color.fromRGBO(41, 43, 68, 1.0);
}
