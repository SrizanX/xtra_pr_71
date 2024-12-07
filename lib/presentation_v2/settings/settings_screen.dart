import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: Icon(Icons.network_cell),
                title: Text("Network mode"),
                subtitle: Text("Subtitle"),
                trailing: Text("24"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.wifi),
                title: Text("Wireles"),
                subtitle: Text("Pinternet"),
                trailing: Icon(Icons.edit),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.key),
                title: Text("Change admin password"),
                subtitle: Text(""),
                trailing: Icon(Icons.edit),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.cell_tower),
                title: Text("Apn Settings"),
                subtitle: Text(""),
                trailing: Icon(Icons.edit),
              ),
              const Divider(),
            ],
          )),
    );
  }

  Widget buildSettingsItem(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print(label);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text("2g"),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
