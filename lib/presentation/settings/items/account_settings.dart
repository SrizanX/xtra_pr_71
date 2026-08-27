import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/demo/demo_mode.dart';
import '../../../data/shared_preferences/prefs_repository.dart';
import '../../components/app_alert_dialog_widget.dart';
import '../../login/login_route.dart';

/// Account controls: signing out of the current (or remembered) session.
class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(
        'Log out',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      subtitle: const Text('Forget this session and return to sign in'),
      onTap: () => _confirmLogout(context),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final router = GoRouter.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const AppAlertDialog(
        title: 'Log out?',
        message: "You'll need to sign in again to reconnect.",
        confirmLabel: 'Log out',
        confirmIcon: Icons.logout,
        isDestructive: true,
      ),
    );
    if (confirmed != true) return;
    await PrefsRepository().clearCredentials();
    DemoMode.enabled = false;
    router.go(LoginRoute.route);
  }
}
