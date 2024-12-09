import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/wireless/bloc/wireless_info_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/wifi_settings/wifi_settings_editor_dialog.dart';

import '../network_mode/bloc/network_mode_cubit.dart';

class WifiSettings extends StatelessWidget {
  const WifiSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wifi),
      title: const Text("Wireles"),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Pinternet"),
          Row(
            children: [
              Icon(Icons.phone_android, size: 14,),
              const Text("5"),
            ],
          )
        ],
      ),
      trailing: IconButton(
          onPressed: () {
            _showWifiSettingsEditorDialog(context);
          },
          icon: const Icon(Icons.edit)),
    );
  }

  void _showWifiSettingsEditorDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<WirelessInfoCubit>(),
          child: const WifiSettingsEditorDialog(),
        );
      },
    );
  }
}
