import 'package:flutter/material.dart';

class SignalStrengthIndicatorBar extends StatelessWidget {
  final String signalStrength;

  const SignalStrengthIndicatorBar({
    super.key,
    required this.signalStrength,
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
              height: (index + 1) * 38.0, // Gradually increasing height
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getColorForSignalLevel(int level) {
    // Determine color based on signal strength
    if (level == 5) {
      return Colors.green; // Excellent signal
    } else if (level == 4) {
      return Colors.lightGreen;
    } else if (level == 3) {
      return Colors.yellow;
    } else if (level == 2) {
      return Colors.orange;
    } else {
      return Colors.red; // Poor signal
    }
  }
}
