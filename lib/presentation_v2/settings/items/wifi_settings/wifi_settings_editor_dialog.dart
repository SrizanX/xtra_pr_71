import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/home/wireless/bloc/wireless_info_cubit.dart';
import '../../../../presentation/home/wireless/bloc/wireless_info_state.dart';
import '../../../../presentation/login/login_components.dart';

class WifiSettingsEditorDialog extends StatelessWidget {
  const WifiSettingsEditorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 44),
            BlocBuilder<WirelessInfoCubit, WirelessInfoState>(
                builder: (context, state) {
              return TextFormField(
                initialValue: state.wifiName,
                onChanged: (value) {
                  context
                      .read<WirelessInfoCubit>()
                      .onUpdateWifiName(wifiName: value);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Wifi name",
                    hintText: 'Enter wifi name'),
              );
            }),
            const SizedBox(height: 16),
            BlocBuilder<WirelessInfoCubit, WirelessInfoState>(
              builder: (context, state) {
                return PasswordField(
                    initialValue: state.password,
                    onChanged: (value) {
                      context
                          .read<WirelessInfoCubit>()
                          .onUpdatePassword(password: value);
                    });
              },
            ),

            /** Max device num */
            BlocBuilder<WirelessInfoCubit, WirelessInfoState>(
                builder: (context, state) {
              return Column(
                children: [
                  Text("Maximum number: ${state.maxDevices.toInt()}"),
                  Slider(
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: state.maxDevices.toInt().toString(),
                      value: state.maxDevices,
                      onChanged: (va) {
                        context
                            .read<WirelessInfoCubit>()
                            .onUpdateMaxDeviceCount(maxDevices: va);
                      })
                ],
              );
            }),
            FilledButton(
                onPressed: () {
                  context.read<WirelessInfoCubit>().updateWirelessSettings();
                },
                child: const Text("Apply"))
          ],
        ),
      ),
    );
  }
}
