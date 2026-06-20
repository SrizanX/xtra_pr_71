import 'package:flutter/widgets.dart';

/// Size buckets the whole app reasons about.
///
/// A device is classified from [MediaQueryData.size] using its *shortest side*
/// so the same physical device lands in the same bucket whether it is held in
/// portrait or landscape (a tablet stays a tablet when rotated).
enum DeviceType {
  /// Compact phones — e.g. small/budget Androids. shortestSide < 320.
  smallPhone,

  /// Regular phones. 320 <= shortestSide < 480.
  mediumPhone,

  /// Large ~5" phones. 480 <= shortestSide < 600.
  largePhone,

  /// 7" tablets and foldables. 600 <= shortestSide < 720.
  tablet,

  /// 10" tablets, desktop and web. shortestSide >= 720.
  largeScreen;

  bool get isPhone =>
      this == smallPhone || this == mediumPhone || this == largePhone;

  bool get isTabletOrLarger => this == tablet || this == largeScreen;
}

/// Layout breakpoints in logical pixels, measured against the shortest side.
///
/// These follow Android's documented "smallest width" (sw) qualifiers, which
/// classify a device by the smaller of its two sides regardless of orientation:
///
/// * sw320 — small phone screen
/// * sw480 — large ~5" phone screen
/// * sw600 — 7" tablet
/// * sw720 — 10" tablet
///
/// Each constant is the lower bound (exclusive of the tier below it) of the
/// next-larger tier.
abstract final class Breakpoints {
  static const double smallPhone = 320;
  static const double largePhone = 480;
  static const double tablet = 600;
  static const double largeScreen = 720;
}

DeviceType deviceTypeForShortestSide(double shortestSide) {
  if (shortestSide < Breakpoints.smallPhone) return DeviceType.smallPhone;
  if (shortestSide < Breakpoints.largePhone) return DeviceType.mediumPhone;
  if (shortestSide < Breakpoints.tablet) return DeviceType.largePhone;
  if (shortestSide < Breakpoints.largeScreen) return DeviceType.tablet;
  return DeviceType.largeScreen;
}

/// A value that can differ per [DeviceType].
///
/// Only [smallPhone] is required; any tier left null falls back to the next
/// smaller tier that was provided. This keeps call sites terse — you only spell
/// out the breakpoints that actually need to change.
///
/// ```dart
/// const padding = ResponsiveValue(smallPhone: 12, mediumPhone: 16, tablet: 24);
/// final value = padding.resolve(context.deviceType);
/// ```
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.smallPhone,
    this.mediumPhone,
    this.largePhone,
    this.tablet,
    this.largeScreen,
  });

  final T smallPhone;
  final T? mediumPhone;
  final T? largePhone;
  final T? tablet;
  final T? largeScreen;

  T resolve(DeviceType type) {
    switch (type) {
      case DeviceType.smallPhone:
        return smallPhone;
      case DeviceType.mediumPhone:
        return mediumPhone ?? smallPhone;
      case DeviceType.largePhone:
        return largePhone ?? mediumPhone ?? smallPhone;
      case DeviceType.tablet:
        return tablet ?? largePhone ?? mediumPhone ?? smallPhone;
      case DeviceType.largeScreen:
        return largeScreen ?? tablet ?? largePhone ?? mediumPhone ?? smallPhone;
    }
  }
}
