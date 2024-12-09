import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/network_mode/bloc/network_mode_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/network_mode/bloc/network_mode_state.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/network_mode/network_mode_editor_dialog.dart';

class NetworkModeSettings extends StatelessWidget {
  const NetworkModeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModeCubit, NetworkModeState>(
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.network_cell),
          title: const Text("Network mode"),
          subtitle: Text(state.networkMode?.label ?? ""),
          trailing: IconButton(
            onPressed: () {
              _showNetworkModeEditorDialog(context);
            },
            icon: const Icon(Icons.edit),
          ),
        );
      },
    );
  }

  void _showNetworkModeEditorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<NetworkModeCubit>(),
          child: const NetworkModeEditorDialog(),
        );
      },
    );
  }
}
