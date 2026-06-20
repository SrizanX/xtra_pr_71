import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/settings/items/wifi_settings/wifi_settings_editor_dialog.dart';
import '../../../../design/design_system.dart';
import 'bloc/wireless_info_cubit.dart';
import 'bloc/wireless_info_state.dart';

class WifiSettings extends StatelessWidget {
  const WifiSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WirelessInfoCubit, WirelessInfoState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.wifi),
          title: const Text("Wireless"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  state.wifiName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.phone_android, size: 14),
                  const SizedBox(width: AppSpacing.xxs),
                  Text("${state.maxDevices.toInt()}"),
                ],
              ),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                _showWifiSettingsEditorDialog(context);
              },
              icon: const Icon(Icons.edit)),
        );
      },
    );
  }

  void _showWifiSettingsEditorDialog(BuildContext context) {
    showDialog(
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
