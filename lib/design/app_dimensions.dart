import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'responsive.dart';

/// Resolved component sizes for the current screen.
///
/// Keeps the magic numbers that used to live inline in widgets (battery box,
/// power button, toggle tiles, page max-width…) in one place and lets them
/// scale per [DeviceType]. Read it once per build:
///
/// ```dart
/// final dimens = AppDimensions.of(context);
/// PowerButton(size: dimens.powerButtonSize);
/// ```
class AppDimensions {
  const AppDimensions({
    required this.pageMaxWidth,
    required this.screenPadding,
    required this.toggleButtonSize,
    required this.powerButtonSize,
    required this.powerIconSize,
    required this.batteryHeight,
    required this.batteryWidth,
    required this.indicatorHeight,
    required this.heroIconSize,
  });

  /// Max width content is constrained to before it starts centering.
  final double pageMaxWidth;

  /// Default outer padding for a screen body.
  final double screenPadding;

  final double toggleButtonSize;
  final double powerButtonSize;
  final double powerIconSize;
  final double batteryHeight;
  final double batteryWidth;

  /// Height for bar-style indicators (signal strength, etc.).
  final double indicatorHeight;

  /// Large decorative/hero icon (e.g. login screen router glyph).
  final double heroIconSize;

  factory AppDimensions.forDevice(DeviceType type) {
    switch (type) {
      case DeviceType.smallPhone:
        return const AppDimensions(
          pageMaxWidth: 480,
          screenPadding: 12,
          toggleButtonSize: 84,
          powerButtonSize: 72,
          powerIconSize: 44,
          batteryHeight: 104,
          batteryWidth: 68,
          indicatorHeight: 104,
          heroIconSize: 88,
        );
      case DeviceType.mediumPhone:
        return const AppDimensions(
          pageMaxWidth: 480,
          screenPadding: 16,
          toggleButtonSize: 100,
          powerButtonSize: 80,
          powerIconSize: 50,
          batteryHeight: 120,
          batteryWidth: 80,
          indicatorHeight: 120,
          heroIconSize: 120,
        );
      case DeviceType.largePhone:
        return const AppDimensions(
          pageMaxWidth: 520,
          screenPadding: 20,
          toggleButtonSize: 112,
          powerButtonSize: 92,
          powerIconSize: 56,
          batteryHeight: 136,
          batteryWidth: 92,
          indicatorHeight: 136,
          heroIconSize: 140,
        );
      case DeviceType.tablet:
        return const AppDimensions(
          pageMaxWidth: 600,
          screenPadding: 24,
          toggleButtonSize: 128,
          powerButtonSize: 104,
          powerIconSize: 64,
          batteryHeight: 160,
          batteryWidth: 108,
          indicatorHeight: 160,
          heroIconSize: 160,
        );
      case DeviceType.largeScreen:
        return const AppDimensions(
          pageMaxWidth: 640,
          screenPadding: 32,
          toggleButtonSize: 140,
          powerButtonSize: 120,
          powerIconSize: 72,
          batteryHeight: 184,
          batteryWidth: 124,
          indicatorHeight: 184,
          heroIconSize: 184,
        );
    }
  }

  static AppDimensions of(BuildContext context) =>
      AppDimensions.forDevice(context.deviceType);
}
