import 'package:flutter/material.dart';

import '../../design/design_system.dart';

/// Full-screen failure state — a muted icon, the error message and an optional
/// retry action. Styled to sit on the app's dark surfaces like the rest of the
/// screens rather than a bare line of text.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage, this.onRetry});

  final String errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Icon(
                Icons.cloud_off_outlined,
                size: 32,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.6),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
