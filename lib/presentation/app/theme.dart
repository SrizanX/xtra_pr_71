import 'package:flutter/material.dart';

import '../../design/app_spacing.dart';
import '../../design/app_typography.dart';
import '../../design/app_colors.dart';

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.blue500,
  onPrimary: Colors.white,
  secondary: AppColors.greenAccent,
  onSecondary: Colors.black12,
  error: Colors.red,
  onError: Colors.black12,
  surface: const Color.fromRGBO(41, 43, 68, 1.0),
  onSurface: Colors.white,
  secondaryContainer: const Color.fromRGBO(41, 43, 68, 1.0),
);

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.blue500,
  onPrimary: Colors.white,
  secondary: AppColors.greenAccent,
  onSecondary: Colors.white,
  error: const Color(0xffd32f2f),
  onError: Colors.white,
  surface: const Color(0xfff4f5f9),
  onSurface: const Color(0xff181a2a),
  secondaryContainer: Colors.white,
);

/// Builds the app's full [ThemeData] from a brightness-specific [ColorScheme]
/// so light and dark stay structurally identical — only the tokens differ.
ThemeData _buildTheme(ColorScheme colorScheme) {
  final textTheme = AppTypography.textTheme(colorScheme.onSurface);
  final hairline = colorScheme.onSurface.withValues(alpha: 0.12);
  final mutedOnSurface = colorScheme.onSurface.withValues(alpha: 0.5);

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.surface,
    colorScheme: colorScheme,
    textTheme: textTheme,
    // Stock AlertDialogs (admin password, timezone, refresh rate, …) inherit
    // this so they match the styled AppAlertDialog: a rounded card with a
    // hairline border and readable text on the theme's surface.
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.secondaryContainer,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: hairline),
      ),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.85),
        height: 1.4,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    dividerTheme: DividerThemeData(
      color: hairline,
      space: AppSpacing.xl,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
      elevation: 0,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : mutedOnSurface,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : mutedOnSurface,
        ),
      ),
    ),
    // Keep the side rail (tablet/large screens) consistent with the bottom nav:
    // blue indicator + blue selected icon/label, dimmed when unselected.
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
      selectedIconTheme: IconThemeData(color: colorScheme.primary),
      unselectedIconTheme: IconThemeData(color: mutedOnSurface),
      selectedLabelTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: mutedOnSurface,
      ),
    ),
    // Selected segment uses the app's blue accent (matches the SMS Inbox/Sent
    // toggle) instead of the default M3 secondaryContainer.
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary
              : Colors.transparent,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.onPrimary
              : colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    ),
  );
}

final ThemeData darkTheme = _buildTheme(darkColorScheme);
final ThemeData lightTheme = _buildTheme(lightColorScheme);
