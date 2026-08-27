import 'package:flutter/material.dart';

/// Brand accent palette — the single source of raw color values.
///
/// These are theme-independent (used the same in light and dark) for brand
/// accents, gauges and decorative fills that don't map onto a Material color
/// role. For anything that should flip with the theme — body text, icons,
/// surfaces, borders — use `Theme.of(context).colorScheme` instead; see
/// `presentation/app/theme.dart` for the light/dark ColorScheme definitions.
/// Opacity variants are applied at the call site with `.withValues(alpha: …)`.
abstract final class AppColors {
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
}
