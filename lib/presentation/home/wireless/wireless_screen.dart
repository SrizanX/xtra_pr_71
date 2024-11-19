import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/wireless/bloc/wireless_info_cubit.dart';
import 'package:xtra_pr_71/presentation/home/wireless/bloc/wireless_info_state.dart';
import 'package:xtra_pr_71/presentation/login/login_components.dart';

class WirelessScreen extends StatelessWidget {
  const WirelessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wireless"),
      ),
      body: BlocProvider(
        create: (context) => WirelessInfoCubit()..fetchWirelessSettings(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<WirelessInfoCubit, WirelessInfoState>(
                builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
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
                              Text(
                                  "Maximum number: ${state.maxDevices.toInt()}"),
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
                              context
                                  .read<WirelessInfoCubit>()
                                  .updateWirelessSettings();
                            },
                            child: const Text("Apply"))
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
