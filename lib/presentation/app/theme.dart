import 'package:flutter/material.dart';

import '../../design/app_spacing.dart';
import '../../design/app_typography.dart';
import '../../design/color_seleection.dart';

final ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: ColorSelection.blue_500.color,
  onPrimary: ColorSelection.white.color,
  secondary: ColorSelection.greenAccent.color,
  onSecondary: Colors.black12,
  error: Colors.red,
  onError: Colors.black12,
  surface: ColorSelection.darkBlueTransparent.color,
  onSurface: ColorSelection.white.color,
  secondaryContainer: ColorSelection.darkBlue.color,
);

final ThemeData theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: ColorSelection.darkBlue.color,
  colorScheme: _colorScheme,
  textTheme: AppTypography.textTheme(_colorScheme.onSurface),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorSelection.darkBlue.color,
    foregroundColor: ColorSelection.white.color,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
  dividerTheme: DividerThemeData(
    color: ColorSelection.white.color.withValues(alpha: 0.12),
    space: AppSpacing.xl,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: ColorSelection.darkBlue.color,
    indicatorColor: ColorSelection.blue_500.color.withValues(alpha: 0.18),
    elevation: 0,
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: states.contains(WidgetState.selected)
            ? ColorSelection.blue_500.color
            : ColorSelection.white.color.withValues(alpha: 0.5),
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? ColorSelection.blue_500.color
            : ColorSelection.white.color.withValues(alpha: 0.5),
      ),
    ),
  ),
  // Keep the side rail (tablet/large screens) consistent with the bottom nav:
  // blue indicator + blue selected icon/label, dimmed when unselected.
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: ColorSelection.darkBlue.color,
    indicatorColor: ColorSelection.blue_500.color.withValues(alpha: 0.18),
    selectedIconTheme: IconThemeData(color: ColorSelection.blue_500.color),
    unselectedIconTheme: IconThemeData(
      color: ColorSelection.white.color.withValues(alpha: 0.5),
    ),
    selectedLabelTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: ColorSelection.blue_500.color,
    ),
    unselectedLabelTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: ColorSelection.white.color.withValues(alpha: 0.5),
    ),
  ),
  // Selected segment uses the app's blue accent (matches the SMS Inbox/Sent
  // toggle) instead of the default M3 secondaryContainer.
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? ColorSelection.blue_500.color
            : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? ColorSelection.white.color
            : ColorSelection.white.color.withValues(alpha: 0.7),
      ),
    ),
  ),
);
