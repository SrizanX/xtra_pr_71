import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../domain/entity/network_mode.dart';
import '../../../components/app_dialog_widget.dart';
import 'bloc/network_mode_cubit.dart';
import 'bloc/network_mode_state.dart';

class NetworkModeEditorDialog extends StatefulWidget {
  const NetworkModeEditorDialog({super.key});

  @override
  State<NetworkModeEditorDialog> createState() =>
      _NetworkModeEditorDialogState();
}

class _NetworkModeEditorDialogState extends State<NetworkModeEditorDialog> {
  NetworkMode? networkMode;

  @override
  void initState() {
    super.initState();
    networkMode = context.read<NetworkModeCubit>().state.networkMode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkModeCubit, NetworkModeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          Fluttertoast.showToast(msg: state.errorMessage!);
        }
      },
      child: AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /** Network mode */
            _buildNetworkDropdown(context),
            FilledButton(
              onPressed: () {
                context.read<NetworkModeCubit>().updateNetworkMode(networkMode);
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkDropdown(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Network mode", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 16),
        DropdownButton<NetworkMode>(
          dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
          value: networkMode,
          items: NetworkMode.values
              .map(
                (mode) => DropdownMenuItem(
                  value: mode,
                  child: Text(mode.label),
                ),
              )
              .toList(),
          onChanged: (selected) {
            setState(() {
              networkMode = selected;
            });
          },
        ),
      ],
    );
  }
}
