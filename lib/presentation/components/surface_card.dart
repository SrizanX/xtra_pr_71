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

  /// Optional accent border. Defaults to the hairline border.
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final fill = onSurface.withValues(alpha: 0.045);
    final border = onSurface.withValues(alpha: 0.07);
    final gradient = gradientColors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? fill : null,
        gradient: gradient == null
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
        border: Border.all(color: borderColor ?? border),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // A plain translucent Container has a background color but no Material
      // ancestor of its own, so any ListTile/InkWell inside it paints splashes
      // onto the Scaffold's Material underneath — hidden behind this fill.
      // A transparent Material here gives them the right surface to paint on.
      child: Material(type: MaterialType.transparency, child: child),
    );
  }
}
