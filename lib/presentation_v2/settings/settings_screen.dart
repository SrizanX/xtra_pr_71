import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/apn_settings/apn_settings.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/network_mode/network_mode_settings_widget.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/wifi_settings/wifi_settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const SafeArea(
          minimum: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkModeSettings(),
              Divider(),
              WifiSettings(),
              Divider(),
              // ListTile(
              //   leading: Icon(Icons.key),
              //   title: Text("Change admin password"),
              //   subtitle: Text(""),
              //   trailing: Icon(Icons.edit),
              // ),
              // Divider(),
              // ApnSettings(),
              // Divider(),
            ],
          )),
    );
  }
}
