import 'package:flutter/material.dart';
import 'package:xtra_pr_71/design/design_system.dart';
import 'app_dialog_widget.dart';

/// A compact confirmation dialog with a title, message and a
/// cancel / confirm action pair.
///
/// Use [confirmLabel] / [confirmIcon] to label the positive action and
/// [isDestructive] to colour it with the error tone (e.g. shutdown).
class AppAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData? confirmIcon;
  final bool isDestructive;
  final Function()? onPositiveButtonClick;

  const AppAlertDialog({
    super.key,
    this.title,
    this.message,
    this.confirmLabel = 'Yes',
    this.cancelLabel = 'Cancel',
    this.confirmIcon = Icons.power_settings_new,
    this.isDestructive = false,
    this.onPositiveButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;

    return AppDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      confirmIcon ?? Icons.info_outline,
                      size: 20,
                      color: accent,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      title!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (message != null)
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: onSurface.withValues(alpha: 0.85),
                  height: 1.4,
                ),
              ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(cancelLabel),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton.icon(
                  // When no explicit handler is given, behave as a
                  // confirm/cancel prompt that returns a bool to the caller.
                  onPressed:
                      onPositiveButtonClick ?? () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  icon: confirmIcon == null
                      ? const SizedBox.shrink()
                      : Icon(confirmIcon, size: 18),
                  label: Text(confirmLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
