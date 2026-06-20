import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../design/design_system.dart';

/// A circular progress ring with free-form centre content.
///
/// Used for the Battery and Signal gauges on Home: a faint track with a rounded
/// accent-coloured arc sweeping clockwise from the top, and a stacked icon +
/// value drawn in the middle.
class RadialGauge extends StatelessWidget {
  const RadialGauge({
    super.key,
    required this.progress,
    required this.color,
    required this.center,
    this.size = 114,
    this.strokeWidth = 11,
  });

  /// 0.0–1.0. Clamped before painting.
  final double progress;
  final Color color;
  final Widget center;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GaugePainter(
          progress: progress.clamp(0.0, 1.0),
          color: color,
          trackColor: AppColors.white.withValues(alpha: 0.08),
          strokeWidth: strokeWidth,
        ),
        child: Center(child: center),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;

    final arc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    const startAngle = -math.pi / 2; // 12 o'clock
    canvas.drawArc(rect, startAngle, 2 * math.pi * progress, false, arc);
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.strokeWidth != strokeWidth;
}

/// Standard centre block for a [RadialGauge]: an icon above a big percentage.
class GaugeReadout extends StatelessWidget {
  const GaugeReadout({
    super.key,
    required this.icon,
    required this.value,
    required this.accent,
    this.unit = '%',
  });

  final IconData icon;
  final int value;
  final Color accent;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: accent, size: 18),
        const SizedBox(height: AppSpacing.xxs),
        Text.rich(
          TextSpan(
            text: '$value',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
            children: [
              TextSpan(
                text: unit,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
