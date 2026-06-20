import 'package:flutter/material.dart';

/// Confirms a MAC-filter change. Applying any filter change restarts the
/// router and briefly drops every connection, so we warn first.
/// Returns true if the user chooses to continue.
Future<bool> confirmMacFilterRestart(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Restart router?'),
      content: const Text(
        'Changing MAC filtering restarts the router and briefly disconnects '
        'all devices. Continue?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
