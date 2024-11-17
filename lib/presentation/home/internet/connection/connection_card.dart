import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../internet_cubit.dart';
import '../network_mode.dart';

class ConnectionCard extends StatelessWidget {
  const ConnectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /** Network mode */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Network mode",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 16),
                      DropdownButton<NetworkMode>(
                        value: state.networkMode,
                        items: NetworkMode.values
                            .map(
                              (mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode.label),
                              ),
                            )
                            .toList(),
                        onChanged: (selected) {
                          context
                              .read<InternetCubit>()
                              .updateNetworkMode(selected);
                        },
                      ),
                    ],
                  ),
                  /** Mobile data */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mobile Data",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch(
                          value: state.isMobileDataEnabled,
                          onChanged: (val) {
                            context.read<InternetCubit>().updateMobileData(val);
                          }),
                    ],
                  ),
                  /** Roaming */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Roaming",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch(
                          value: state.isRoamingEnabled,
                          onChanged: (val) {
                            context.read<InternetCubit>().updateRoaming(val);
                          }),
                    ],
                  ),
                  FilledButton(
                      onPressed: () {
                        context.read<InternetCubit>().apply();
                      },
                      child: const Text("Apply"))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
