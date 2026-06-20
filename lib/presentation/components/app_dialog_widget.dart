import 'package:flutter/material.dart';
import 'package:xtra_pr_71/design/design_system.dart';

class AppDialog extends StatelessWidget {
  final Widget child;

  const AppDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.colorScheme.secondaryContainer,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        // The dialog surface matches the scaffold background, so a hairline
        // border keeps it visually separated from the page behind it.
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: child,
      ),
    );
  }
}
