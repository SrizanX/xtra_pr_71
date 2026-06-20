import 'package:flutter/material.dart';

import '../../../design/design_system.dart';

class ToggleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isOn;
  final void Function()? onTap;
  final void Function()? onLongPress;

  /// Side length of the square tile. Defaults to the responsive size for the
  /// current device when not provided.
  final double? size;

  const ToggleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isOn,
    this.onTap,
    this.onLongPress,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final side = size ?? AppDimensions.of(context).toggleButtonSize;
    return SizedBox(
      height: side,
      width: side,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isOn
                  ? [
                      const Color(0xff5492f7),
                      const Color(0xffa7e1ec),
                    ]
                  : [
                      const Color(0xff363346),
                      const Color(0xff363346),
                    ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isOn ? Colors.white : const Color(0xFF292637),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    icon,
                    size: side * 0.26,
                    color: isOn ? const Color(0xFF004d66) : Colors.white54,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isOn ? const Color(0xFF004d66) : Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
