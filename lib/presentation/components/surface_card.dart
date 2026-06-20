import 'package:flutter/material.dart';

import '../../design/design_system.dart';

/// The translucent "glass" card used across the PR71 surfaces.
///
/// A faint white fill over the dark blue scaffold with a hairline white border
/// and large rounded corners — the building block for every panel in the app.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.borderRadius = AppRadius.lg,
    this.gradientColors,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  /// Optional accent gradient (e.g. the green internet card). When null the
  /// default faint white fill is used.
  final List<Color>? gradientColors;

  /// Optional accent border. Defaults to the hairline white border.
  final Color? borderColor;

  static Color get _fill => AppColors.white.withValues(alpha: 0.045);
  static Color get _border =>
      AppColors.white.withValues(alpha: 0.07);

  @override
  Widget build(BuildContext context) {
    final gradient = gradientColors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? _fill : null,
        gradient: gradient == null
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
        border: Border.all(color: borderColor ?? _border),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
