import 'package:flutter/material.dart';

import '../../design/app_spacing.dart';
import '../../design/app_typography.dart';
import '../../design/app_colors.dart';

final ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.blue500,
  onPrimary: AppColors.white,
  secondary: AppColors.greenAccent,
  onSecondary: Colors.black12,
  error: Colors.red,
  onError: Colors.black12,
  surface: AppColors.darkBlue,
  onSurface: AppColors.white,
  secondaryContainer: AppColors.darkBlue,
);

final TextTheme _textTheme = AppTypography.textTheme(_colorScheme.onSurface);

final ThemeData theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.darkBlue,
  colorScheme: _colorScheme,
  textTheme: _textTheme,
  // Stock AlertDialogs (admin password, timezone, refresh rate, …) inherit
  // this so they match the styled AppAlertDialog: dark surface, rounded card
  // with a hairline border, and readable white text.
  dialogTheme: DialogThemeData(
    backgroundColor: _colorScheme.secondaryContainer,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: BorderSide(
        color: _colorScheme.onSurface.withValues(alpha: 0.12),
      ),
    ),
    titleTextStyle: _textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: _textTheme.bodyMedium?.copyWith(
      color: _colorScheme.onSurface.withValues(alpha: 0.85),
      height: 1.4,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBlue,
    foregroundColor: AppColors.white,
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
    color: AppColors.white.withValues(alpha: 0.12),
    space: AppSpacing.xl,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.darkBlue,
    indicatorColor: AppColors.blue500.withValues(alpha: 0.18),
    elevation: 0,
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: states.contains(WidgetState.selected)
            ? AppColors.blue500
            : AppColors.white.withValues(alpha: 0.5),
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColors.blue500
            : AppColors.white.withValues(alpha: 0.5),
      ),
    ),
  ),
  // Keep the side rail (tablet/large screens) consistent with the bottom nav:
  // blue indicator + blue selected icon/label, dimmed when unselected.
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: AppColors.darkBlue,
    indicatorColor: AppColors.blue500.withValues(alpha: 0.18),
    selectedIconTheme: IconThemeData(color: AppColors.blue500),
    unselectedIconTheme: IconThemeData(
      color: AppColors.white.withValues(alpha: 0.5),
    ),
    selectedLabelTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.blue500,
    ),
    unselectedLabelTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.white.withValues(alpha: 0.5),
    ),
  ),
  // Selected segment uses the app's blue accent (matches the SMS Inbox/Sent
  // toggle) instead of the default M3 secondaryContainer.
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.blue500
            : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.7),
      ),
    ),
  ),
);
