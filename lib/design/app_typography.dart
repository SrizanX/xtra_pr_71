import 'package:flutter/material.dart';

/// App text theme.
///
/// The app previously relied on Flutter's default Material text theme, so type
/// sizes were implicit and inconsistent. This defines them explicitly on a dark
/// surface. Sizes deliberately stay device-independent here — global scaling is
/// handled once in [clampTextScaler] (applied in the app builder) rather than
/// by hand-tuning every style per breakpoint.
abstract final class AppTypography {
  static TextTheme textTheme(Color onSurface) {
    final muted = onSurface.withValues(alpha: 0.7);
    return TextTheme(
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: onSurface),
      bodyMedium: TextStyle(fontSize: 14, color: onSurface),
      bodySmall: TextStyle(fontSize: 12, color: muted),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
    );
  }

  /// Lower/upper bounds for the OS text-scale setting.
  ///
  /// Accessibility scaling is respected, but clamped so very large system font
  /// settings can't overflow the dense control layouts, and very small ones
  /// stay legible.
  static const double minTextScale = 0.9;
  static const double maxTextScale = 1.3;
}

/// Clamp the inherited [TextScaler] to the app's supported range.
///
/// Call from `MaterialApp.builder`:
/// ```dart
/// builder: (context, child) => MediaQuery.withClampedTextScaling(
///   minScaleFactor: AppTypography.minTextScale,
///   maxScaleFactor: AppTypography.maxTextScale,
///   child: child!,
/// ),
/// ```
TextScaler clampTextScaler(TextScaler scaler) => scaler.clamp(
  minScaleFactor: AppTypography.minTextScale,
  maxScaleFactor: AppTypography.maxTextScale,
);
