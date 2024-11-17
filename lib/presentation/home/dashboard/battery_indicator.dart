import 'dart:math';

import 'package:flutter/material.dart';

class VerticalBatteryIndicator extends StatefulWidget {
  final String percentage;

  const VerticalBatteryIndicator({
    super.key,
    required this.percentage,
  });

  @override
  State<VerticalBatteryIndicator> createState() =>
      _VerticalBatteryIndicatorState();
}

class _VerticalBatteryIndicatorState extends State<VerticalBatteryIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for the sinusoidal wave
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parsedPercentage =
        double.parse(widget.percentage.replaceAll('%', ''));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Battery tip
        Container(
          width: 40,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 2),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Battery body
            Container(
              width: 80,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // Liquid inside the battery
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(80, 180),
                    painter: SinWavePainter(
                      percentage: parsedPercentage,
                      animationValue: _animation.value,
                      color: _getColorForPercentage(parsedPercentage),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Percentage text
        Text(
          widget.percentage,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage > 50) {
      return Colors.green;
    } else if (percentage > 20) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}

class SinWavePainter extends CustomPainter {
  final double percentage;
  final double animationValue;
  final Color color;

  SinWavePainter({
    required this.percentage,
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Calculate the height of the liquid based on percentage
    final liquidHeight = size.height * (percentage / 100);

    // Draw the liquid body
    final liquidPath = Path();
    for (double x = 0; x <= size.width; x++) {
      final waveHeight = 2 * sin((x / size.width) * 2 * pi + animationValue);
      final y = size.height - liquidHeight + waveHeight;
      if (x == 0) {
        liquidPath.moveTo(x, y);
      } else {
        liquidPath.lineTo(x, y);
      }
    }

    // Close the path to form the liquid shape
    liquidPath.lineTo(size.width, size.height);
    liquidPath.lineTo(0, size.height);
    liquidPath.close();

    canvas.drawPath(liquidPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
