import 'package:flutter/material.dart';

class SignalStrengthIndicatorBar extends StatelessWidget {
  final String signalStrength;
  final double width;
  final double height;

  const SignalStrengthIndicatorBar({
    super.key,
    required this.signalStrength,
    this.width = 100,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the signal strength (it should be between 1 and 5)
    final int strength = int.tryParse(signalStrength) ?? 0;

    // Ensure the value is within the range 1-5
    final level = strength.clamp(1, 5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Signal tower icon (small tower for visual effect)
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              width: 12, // Narrow bars for a more old-school look
              height: (index + 1) * 30.0, // Gradually increasing height
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index < level
                    ? _getColorForSignalLevel(level)
                    : Colors.grey[300], // Empty bars are light grey
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        // Display signal strength level as text
        Text(
          "$level / 5",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Color _getColorForSignalLevel(int level) {
    // Determine color based on signal strength
    if (level == 5) {
      return const Color(0xff10db90);
    } else if (level == 4) {
      return const Color(0xff57f3ba);
    } else if (level == 3) {
      return Colors.yellow;
    } else if (level == 2) {
      return Colors.orange;
    } else {
      return Colors.red; // Poor signal
    }
  }
}
