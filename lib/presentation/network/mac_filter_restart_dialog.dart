import 'package:flutter/material.dart';

import '../components/app_alert_dialog_widget.dart';

/// Confirms a MAC-filter change. Applying any filter change restarts the
/// router and briefly drops every connection, so we warn first.
/// Returns true if the user chooses to continue.
Future<bool> confirmMacFilterRestart(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const AppAlertDialog(
      title: 'Restart router?',
      message: 'Changing MAC filtering restarts the router and briefly '
          'disconnects all devices. Continue?',
      confirmLabel: 'Continue',
      confirmIcon: Icons.restart_alt,
    ),
  );
  return confirmed ?? false;
}
