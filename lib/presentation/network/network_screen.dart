import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design/design_system.dart';
import '../../domain/entity/apn/apn_settings.dart';
import '../../domain/entity/device/connected_device.dart';
import '../components/surface_card.dart';
import '../devices/bloc/connected_devices_cubit.dart';
import '../devices/bloc/connected_devices_state.dart';
import 'apn_editor_screen.dart';
import 'bloc/apn_cubit.dart';
import 'bloc/apn_state.dart';
import 'bloc/mac_filter_cubit.dart';
import 'bloc/mac_filter_state.dart';
import 'mac_blocklist_editor_screen.dart';
import 'mac_filter_restart_dialog.dart';

/// The Network tab: upstream connection (APN), access control (MAC filter) and
/// the connected clients — with the ability to block a client into the MAC
/// deny list right from its row.
class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocListener<MacFilterCubit, MacFilterState>(
          listenWhen: (_, current) => current.message != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xxxl,
            ),
            children: const [
              _Header(),
              SizedBox(height: AppSpacing.lg),
              _ApnCard(),
              SizedBox(height: AppSpacing.md),
              _MacFilterCard(),
              SizedBox(height: AppSpacing.md),
              _ConnectedDevices(),
              SizedBox(height: AppSpacing.md),
              _BlockedDevices(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Network',
                style:
                    textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Access point · filtering · devices',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        _SquareIconButton(
          icon: Icons.refresh,
          onTap: () {
            context.read<ConnectedDevicesCubit>().fetchConnectedDevices();
            context.read<MacFilterCubit>().fetchMacFilter();
            context.read<ApnCubit>().fetchApnSettings();
          },
        ),
      ],
    );
  }
}

// --- APN ---------------------------------------------------------------------

class _ApnCard extends StatelessWidget {
  const _ApnCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ApnCubit, ApnState>(
      builder: (context, state) {
        final subtitle = switch (state) {
          ApnLoading() => 'Loading…',
          ApnFailed() => 'Failed to load',
          ApnSuccessful(:final settings) =>
            '${settings.name.isEmpty ? 'Not set' : settings.name}'
                '${settings.apn.isEmpty ? '' : ' · ${settings.apn}'}',
        };
        final card = SurfaceCard(
          child: Row(
            children: [
              _IconChip(
                  icon: Icons.cell_tower, accent: AppColors.blue500),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Access Point (APN)',
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color:
                            AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is ApnSuccessful)
                Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: AppColors.white.withValues(alpha: 0.6),
                ),
            ],
          ),
        );
        if (state is! ApnSuccessful) return card;
        return InkWell(
          onTap: () => _openEditor(context, state.settings),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: card,
        );
      },
    );
  }

  void _openEditor(BuildContext context, ApnSettings settings) {
    final cubit = context.read<ApnCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ApnEditorScreen(settings: settings),
        ),
      ),
    );
  }
}

// --- MAC filter mode ---------------------------------------------------------

class _MacFilterCard extends StatelessWidget {
  const _MacFilterCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<MacFilterCubit, MacFilterState>(
      builder: (context, state) {
        final count = state.macs.length;
        final subtitle = state.denyEnabled
            ? '$count ${count == 1 ? 'device' : 'devices'} blocked'
            : 'Filtering off · all devices allowed';
        return SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _IconChip(
                    icon: Icons.shield_outlined,
                    accent: AppColors.amber,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MAC filtering',
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          subtitle,
                          style: textTheme.bodySmall?.copyWith(
                            color:
                                AppColors.white.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.isBusy)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _ModeToggle(
                denyEnabled: state.denyEnabled,
                onChanged: (deny) async {
                  // Turning Deny on prompts for addresses via the editor; the
                  // mode only actually flips once Apply writes the list.
                  if (deny) {
                    _openBlocklistEditor(context, state.macs);
                  } else {
                    final cubit = context.read<MacFilterCubit>();
                    if (await confirmMacFilterRestart(context)) {
                      cubit.setDenyEnabled(false);
                    }
                  }
                },
              ),
              if (state.denyEnabled) ...[
                const SizedBox(height: AppSpacing.xs),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => _openBlocklistEditor(context, state.macs),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Edit blocklist'),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _openBlocklistEditor(BuildContext context, List<String> macs) {
    final cubit = context.read<MacFilterCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: MacBlocklistEditorScreen(initialMacs: macs),
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.denyEnabled, required this.onChanged});

  final bool denyEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _segment(context, 'Off', selected: !denyEnabled, onTap: () => onChanged(false)),
          _segment(context, 'Deny listed', selected: denyEnabled, onTap: () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _segment(
    BuildContext context,
    String label, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    final accent = AppColors.amber;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? accent.withValues(alpha: 0.18) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: selected ? accent.withValues(alpha: 0.5) : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                color: selected
                    ? accent
                    : AppColors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Connected devices -------------------------------------------------------

class _ConnectedDevices extends StatelessWidget {
  const _ConnectedDevices();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final devicesState = context.watch<ConnectedDevicesCubit>().state;
    final filter = context.watch<MacFilterCubit>().state;

    final devices = switch (devicesState) {
      ConnectedDevicesSuccessful(:final devices) => devices,
      _ => const <ConnectedDevice>[],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connected devices (${devices.length})',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (devicesState is ConnectedDevicesLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          )
        else if (devices.isEmpty)
          _emptyText(context, 'No devices connected')
        else
          SurfaceCard(
            padding: EdgeInsets.zero,
            borderRadius: AppRadius.md + 2,
            child: Column(
              children: [
                for (var i = 0; i < devices.length; i++) ...[
                  if (i > 0) _divider(),
                  _DeviceRow(
                    title: devices[i].ipAddress,
                    mac: devices[i].macAddress,
                    blocked: filter.contains(devices[i].macAddress),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

// --- Blocked-but-offline devices ---------------------------------------------

class _BlockedDevices extends StatelessWidget {
  const _BlockedDevices();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final devicesState = context.watch<ConnectedDevicesCubit>().state;
    final filter = context.watch<MacFilterCubit>().state;

    final connectedMacs = switch (devicesState) {
      ConnectedDevicesSuccessful(:final devices) =>
        devices.map((d) => d.macAddress.toLowerCase()).toSet(),
      _ => <String>{},
    };
    final offline = filter.macs
        .where((m) => !connectedMacs.contains(m.toLowerCase()))
        .toList();

    if (offline.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Blocked (not connected)',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.sm),
        SurfaceCard(
          padding: EdgeInsets.zero,
          borderRadius: AppRadius.md + 2,
          child: Column(
            children: [
              for (var i = 0; i < offline.length; i++) ...[
                if (i > 0) _divider(),
                _DeviceRow(title: offline[i], mac: offline[i], blocked: true),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A device/MAC row with a Block / Unblock action.
class _DeviceRow extends StatelessWidget {
  const _DeviceRow({
    required this.title,
    required this.mac,
    required this.blocked,
  });

  final String title;
  final String mac;
  final bool blocked;

  bool get _isValidMac => mac.contains(':');

  /// Warns about the router restart, then runs [action] on the cubit.
  Future<void> _confirmThen(
    BuildContext context,
    void Function(MacFilterCubit) action,
  ) async {
    final cubit = context.read<MacFilterCubit>();
    if (await confirmMacFilterRestart(context)) action(cubit);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          _IconChip(
            icon: blocked ? Icons.block : Icons.devices_other,
            accent: blocked
                ? Theme.of(context).colorScheme.error
                : AppColors.blue500,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  mac.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          if (_isValidMac)
            blocked
                ? TextButton(
                    onPressed: () => _confirmThen(
                      context,
                      (cubit) => cubit.unblockMac(mac),
                    ),
                    child: const Text('Unblock'),
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () => _confirmThen(
                      context,
                      (cubit) => cubit.blockMac(mac),
                    ),
                    child: const Text('Block'),
                  ),
        ],
      ),
    );
  }
}

// --- small shared bits -------------------------------------------------------

class _IconChip extends StatelessWidget {
  const _IconChip({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.md + 1),
      ),
      child: Icon(icon, color: accent, size: 22),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md + 2),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadius.md + 2),
        ),
        child: Icon(
          icon,
          size: 21,
          color: AppColors.white.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

Widget _divider() => Divider(
      height: 1,
      thickness: 1,
      color: AppColors.white.withValues(alpha: 0.06),
    );

Widget _emptyText(BuildContext context, String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
        ),
      ),
    );
