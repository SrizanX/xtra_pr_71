import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation/home/router/cp_dialog.dart';

class RouterControlScreen extends StatelessWidget {
  const RouterControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Router Control'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Control Your Router',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose an action below to manage your router.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ActionButton(
              icon: Icons.power_settings_new,
              label: 'Power Off',
              color: Colors.red,
              onPressed: () {
                // Handle power off action
                _showSnackbar(context, 'Powering Off...');
              },
            ),
            const SizedBox(height: 16),
            ActionButton(
              icon: Icons.restart_alt,
              label: 'Restart',
              color: Colors.orange,
              onPressed: () {
                // Handle restart action
                _showSnackbar(context, 'Restarting Router...');
              },
            ),
            const SizedBox(height: 16),
            ActionButton(
              icon: Icons.refresh,
              label: 'Reset',
              color: Colors.blue,
              onPressed: () {
                // Handle reset action
                _showSnackbar(context, 'Resetting Router...');

                showDialog(context: context, builder: (context){

                  return ChangePasswordDialog();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
