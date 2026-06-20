import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../design/design_system.dart';

/// A selectable refresh interval, in milliseconds. `0` means Off (paused).
class RefreshOption {
  const RefreshOption(this.label, this.ms);
  final String label;
  final int ms;
}

/// A settings row showing the current polling interval. Tapping it opens a
/// dialog to pick a new value (including "Off" to pause).
///
/// Reads/writes through [valueListenable] + [onSelected] so it stays in sync
/// with whatever persists the value — no local state to drift.
class RefreshRateSetting extends StatelessWidget {
  const RefreshRateSetting({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.valueListenable,
    required this.onSelected,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<RefreshOption> options;
  final ValueListenable<int> valueListenable;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder<int>(
      valueListenable: valueListenable,
      builder: (context, current, _) {
        final isOff = current <= 0;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () => _showPicker(context, current),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _labelFor(current),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isOff ? colorScheme.error : colorScheme.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                color: AppColors.white.withValues(alpha: 0.4),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPicker(BuildContext context, int current) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          content: SizedBox(
            width: double.maxFinite,
            child: RadioGroup<int>(
              groupValue: current,
              onChanged: (value) {
                if (value != null) onSelected(value);
                Navigator.pop(dialogContext);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final option in options)
                    RadioListTile<int>(
                      value: option.ms,
                      title: Text(option.label),
                      secondary: option.ms <= 0
                          ? const Icon(Icons.pause_circle_outline)
                          : null,
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  String _labelFor(int ms) {
    for (final option in options) {
      if (option.ms == ms) return option.label;
    }
    return ms <= 0 ? "Off" : "${ms / 1000}s";
  }
}
