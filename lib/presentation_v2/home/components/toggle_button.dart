import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final IconData icon;
  final String label;

  final isOn;

  const ToggleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isOn
                ? [
                    Color(0xff5492f7),
                    Color(0xffa7e1ec),
                  ]
                : [
                    Color(0xff363346),
                    Color(0xff363346),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration:  BoxDecoration(
                color: isOn ?Colors.white:  Color(0xFF292637),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: isOn ? Color(0xFF004d66): Colors.white54,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: isOn ? Color(0xFF004d66): Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
