import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../design/design_system.dart';

/// An analogue speedometer — like a bike's dial — that animates a needle
/// across a 270° arc. The colour ramps green → amber → red toward the top end
/// of the scale to give it that tachometer "redline" feel.
///
/// [value] and [maxValue] share whatever unit the caller passes (we feed it
/// Mbps). The needle tweens smoothly between updates, so polling the router
/// roughly once a second still reads as a live gauge.
class SpeedGauge extends StatelessWidget {
  const SpeedGauge({
    super.key,
    required this.value,
    required this.maxValue,
    required this.unit,
    this.size = 220,
  });

  final double value;
  final double maxValue;
  final String unit;
  final double size;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, maxValue);
    return SizedBox(
      width: size,
      height: size * 0.78,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: clamped),
        builder: (context, animated, _) {
          return CustomPaint(
            painter: _SpeedGaugePainter(
              value: animated,
              maxValue: maxValue,
              trackColor: AppColors.white.withValues(alpha: 0.08),
            ),
            child: _Readout(value: value, unit: unit),
          );
        },
      ),
    );
  }
}

/// Centre block: large speed number with the unit beneath.
class _Readout extends StatelessWidget {
  const _Readout({required this.value, required this.unit});

  final double value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final text = value >= 100
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
    // Sit low in the dial's bottom wedge, clear of the needle hub at centre.
    return Align(
      alignment: const Alignment(0, 0.82),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            unit,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppColors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeedGaugePainter extends CustomPainter {
  _SpeedGaugePainter({
    required this.value,
    required this.maxValue,
    required this.trackColor,
  });

  final double value;
  final double maxValue;
  final Color trackColor;

  // Sweep geometry: a 270° arc with a 90° gap at the bottom.
  static const double _startAngle = math.pi * 0.75; // 135°, lower-left
  static const double _sweepAngle = math.pi * 1.5; // 270°

  static const _zoneColors = [
    AppColors.greenAccent,
    AppColors.amber,
    AppColors.danger,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height * 1.28) / 2 - 6;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final fraction = maxValue <= 0 ? 0.0 : (value / maxValue).clamp(0.0, 1.0);

    // Faint background track.
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _startAngle, _sweepAngle, false, track);

    // Coloured progress arc (green→amber→red sweep gradient).
    if (fraction > 0) {
      final progress = Paint()
        ..shader = SweepGradient(
          startAngle: _startAngle,
          endAngle: _startAngle + _sweepAngle,
          colors: _zoneColors,
          stops: const [0.0, 0.6, 1.0],
          transform: GradientRotation(_startAngle),
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
          rect, _startAngle, _sweepAngle * fraction, false, progress);
    }

    _paintTicks(canvas, center, radius);
    _paintNeedle(canvas, center, radius, fraction);
  }

  void _paintTicks(Canvas canvas, Offset center, double radius) {
    const majorCount = 10; // 10 segments → 11 ticks
    final major = Paint()
      ..color = AppColors.white.withValues(alpha: 0.55)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final minor = Paint()
      ..color = AppColors.white.withValues(alpha: 0.25)
      ..strokeWidth = 1.2;
    final tickRadius = radius - 12;

    for (int i = 0; i <= majorCount * 2; i++) {
      final t = i / (majorCount * 2);
      final angle = _startAngle + _sweepAngle * t;
      final isMajor = i.isEven;
      final inner = tickRadius - (isMajor ? 12 : 6);
      final cos = math.cos(angle);
      final sin = math.sin(angle);
      canvas.drawLine(
        center + Offset(cos * tickRadius, sin * tickRadius),
        center + Offset(cos * inner, sin * inner),
        isMajor ? major : minor,
      );
    }
  }

  void _paintNeedle(
      Canvas canvas, Offset center, double radius, double fraction) {
    final angle = _startAngle + _sweepAngle * fraction;
    final cos = math.cos(angle);
    final sin = math.sin(angle);
    final tip = center + Offset(cos * (radius - 18), sin * (radius - 18));
    // Tail points opposite the tip; the two base corners are perpendicular,
    // making a slim kite-shaped pointer.
    final tail = center + Offset(-cos * 18, -sin * 18);
    final perp = Offset(-sin, cos);
    final baseA = center + perp * 5;
    final baseB = center - perp * 5;

    final needlePath = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(baseA.dx, baseA.dy)
      ..lineTo(tail.dx, tail.dy)
      ..lineTo(baseB.dx, baseB.dy)
      ..close();

    const needleColor = AppColors.danger;
    canvas.drawPath(
      needlePath,
      Paint()
        ..color = needleColor
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
    );

    // Hub.
    canvas.drawCircle(
        center, 9, Paint()..color = AppColors.darkBlue);
    canvas.drawCircle(
      center,
      9,
      Paint()
        ..color = needleColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    canvas.drawCircle(
        center, 3, Paint()..color = AppColors.white);
  }

  @override
  bool shouldRepaint(_SpeedGaugePainter old) =>
      old.value != value || old.maxValue != maxValue;
}
