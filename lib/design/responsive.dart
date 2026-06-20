import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Convenience accessors for responsive layout decisions.
///
/// All reads go through [MediaQuery.sizeOf]/[MediaQuery.orientationOf], so a
/// widget that uses them rebuilds when the window is resized or rotated.
extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;

  DeviceType get deviceType =>
      deviceTypeForShortestSide(screenSize.shortestSide);

  bool get isSmallPhone => deviceType == DeviceType.smallPhone;

  bool get isPhone => deviceType.isPhone;

  bool get isTabletOrLarger => deviceType.isTabletOrLarger;

  /// Resolve a [ResponsiveValue] for the current device type.
  T responsive<T>(ResponsiveValue<T> value) => value.resolve(deviceType);

  /// Inline responsive selection without building a [ResponsiveValue] first.
  ///
  /// ```dart
  /// final cols = context.pick(small: 1, tablet: 2, large: 3);
  /// ```
  T pick<T>({
    required T small,
    T? medium,
    T? largePhone,
    T? tablet,
    T? large,
  }) => ResponsiveValue(
    smallPhone: small,
    mediumPhone: medium,
    largePhone: largePhone,
    tablet: tablet,
    largeScreen: large,
  ).resolve(deviceType);

  /// Multiplier applied to base dimensions so UI grows on big screens and
  /// shrinks on cramped ones. Tuned to stay subtle — not a linear stretch.
  double get scaleFactor => responsive(
    const ResponsiveValue<double>(
      smallPhone: 0.85,
      mediumPhone: 1.0,
      largePhone: 1.08,
      tablet: 1.15,
      largeScreen: 1.25,
    ),
  );

  /// Scale a base dimension by [scaleFactor].
  double scaled(double base) => base * scaleFactor;
}

/// Builds different widget trees per [DeviceType].
///
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, deviceType) =>
///       deviceType.isTabletOrLarger ? const _WideLayout() : const _NarrowLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  @override
  Widget build(BuildContext context) => builder(context, context.deviceType);
}

/// Constrains content to a comfortable reading/interaction width and centers it.
///
/// This is the single most important piece for tablets and large screens: it
/// stops a phone-shaped layout from stretching edge-to-edge into something that
/// looks broken. On phones it is effectively a no-op (the screen is narrower
/// than [maxWidth]); on tablets the content sits centered as a tidy panel.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 560,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
