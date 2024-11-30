import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSettingsItem(context, "Network mode"),
          buildSettingsItem(context, "Wireless"),
          buildSettingsItem(context, "Change admin password"),
          buildSettingsItem(context, "Apn Settings")
        ],
      )),
    );
  }

  Widget buildSettingsItem(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        print(label);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(label), Divider()],
      ),
    );
  }
}
