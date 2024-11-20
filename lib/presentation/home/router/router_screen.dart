import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation/login/login_components.dart';

class RouterScreen extends StatelessWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Router"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PasswordField(),
            SizedBox(
              height: 16,
            ),
            PasswordField(),
            SizedBox(
              height: 16,
            ),
            PasswordField(),
            SizedBox(
              height: 16,
            ),
            FilledButton(onPressed: (){}, child: Text("Change")),
            buildButton(context: context)
          ],
        ),
      ),
    );
  }

  Widget buildButton({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        actionButton(
            icon: Icons.power_settings_new,
            label: "Shutdown",
            onPressed: () {
              _showAlertDialog(
                context: context,
                title: "Shutdown",
                onConfirm: () {
                  print("Reest");
                },
              );
            }),
        actionButton(
            icon: Icons.restart_alt,
            label: "Reboot",
            onPressed: () {
              _showAlertDialog(
                context: context,
                title: "Reboot",
                onConfirm: () {
                  print("Reest");
                },
              );
            }),
        actionButton(
            icon: Icons.refresh,
            label: "Reset",
            onPressed: () {
              _showAlertDialog(
                context: context,
                title: "Reset",
                onConfirm: () {
                  print("Reest");
                },
              );
            }),
      ],
    );
  }

  Future<void> _showAlertDialog({
    required BuildContext context,
    required String title,
    Function()? onConfirm,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return AlertDialog(
            title: Text(title),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (onConfirm != null) onConfirm();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Confirm")),
            ],
          );
        });
  }

  Widget actionButton({
    required IconData icon,
    required String label,
    required void Function() onPressed,
  }) {
    return Column(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Column(
              children: [
                Icon(icon),
              ],
            )),
        Text(label),
      ],
    );
  }
}
