import 'package:flutter/material.dart';

class ApnSettings extends StatelessWidget {
  const ApnSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.cell_tower),
      title: Text("Apn Settings"),
      subtitle: Text(""),
      trailing: Icon(Icons.edit),
    );
  }
}
