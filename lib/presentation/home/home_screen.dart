import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/shared_preferences/prefs_repository.dart';
import '../../design/design_system.dart';
import '../../domain/constants.dart';
import '../data/bloc/statistics_cubit.dart';
import '../data/bloc/statistics_state.dart';
import '../../domain/entity/device_info.dart';
import '../../domain/entity/internet/internet_allowance.dart';
import '../components/app_alert_dialog_widget.dart';
import '../components/app_error_widget.dart';
import '../components/surface_card.dart';
import 'bloc/dashboard_cubit.dart';
import 'bloc/dashboard_state.dart';
import 'bloc/data_connectivity_cubit.dart';
import 'bloc/data_connectivity_state.dart';
import 'bloc/data_limit_cubit.dart';
import 'bloc/data_limit_state.dart';
import 'bloc/home_cubit.dart';
import 'components/home_cards.dart';
import 'components/speed_gauge.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            switch (state) {
              case DashboardLoading():
                return const Center(child: CircularProgressIndicator());
              case DashboardFailed():
                return ErrorView(
                  errorMessage: state.errorMessage,
                  onRetry: () =>
                      context.read<DashboardCubit>().fetchDashBoardData(),
                );
              case DashboardSuccessful():
                return _HomeBody(deviceInfo: state.deviceInfo);
            }
          },
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.deviceInfo});

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimensions.of(context);
    final battery = _batteryPercent(deviceInfo.batteryPercent);
    final signal = deviceInfo.strengthLevel.clamp(0, 5);
    final signalPercent = (signal / 5 * 100).round();
    final devices = deviceInfo.hotcount < 0 ? 0 : deviceInfo.hotcount;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pinned header — stays put while the content below scrolls.
          const SizedBox(height: AppSpacing.sm),
          _Header(deviceInfo: deviceInfo),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GaugeCard(
                            progress: battery / 100,
                            accent: AppColors.greenAccent,
                            icon: Icons.bolt,
                            value: battery,
                            title: 'Battery',
                            subtitle: battery <= 20
                                ? 'Low battery'
                                : 'Battery healthy',
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: deviceInfo.issim
                              ? GaugeCard(
                                  progress: signal / 5,
                                  accent: AppColors.blue500,
                                  icon: Icons.signal_cellular_alt,
                                  value: signalPercent,
                                  title:
                                      'Signal · ${_clean(deviceInfo.networkType)}',
                                  subtitle: _clean(deviceInfo.strengthDbm),
                                )
                              : GaugeCard(
                                  progress: 0,
                                  accent: AppColors.amber,
                                  icon: Icons.sim_card_alert_outlined,
                                  value: 0,
                                  centerText: '—',
                                  title: 'No SIM',
                                  subtitle: 'Insert a SIM card',
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _InternetCard(devices: devices),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(child: _DataUsedTile()),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: StatTile(
                          icon: Icons.devices_other,
                          value: '$devices',
                          label: 'Connected devices',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const _TrafficCard(),
                  const SizedBox(height: AppSpacing.md),
                  const _DataLimitCard(),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Title, online status and the quick-action chips (SMS / settings / power).
class _Header extends StatelessWidget {
  const _Header({required this.deviceInfo});

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final green = AppColors.greenAccent;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _hotspotName(deviceInfo.wifihotname),
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: green, blurRadius: 8)],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _statusLabel(deviceInfo.functionTimes),
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _ActionChip(
          icon: Icons.restart_alt,
          tooltip: 'Reboot',
          onTap: () => _confirmReboot(context),
        ),
        const SizedBox(width: AppSpacing.sm),
        _ActionChip(
          icon: Icons.power_settings_new,
          tooltip: 'Power off',
          accent: Theme.of(context).colorScheme.error,
          onTap: () => _confirmPowerOff(context),
        ),
      ],
    );
  }

  void _confirmReboot(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AppAlertDialog(
        title: 'Reboot',
        message: 'Reboot the router now? It will be unavailable for a minute.',
        confirmLabel: 'Reboot',
        confirmIcon: Icons.restart_alt,
        onPositiveButtonClick: () {
          homeCubit.reboot();
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _confirmPowerOff(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AppAlertDialog(
        title: 'Shutdown',
        message: 'Power off the router now? You will need physical access to '
            'turn it back on.',
        confirmLabel: 'Shut down',
        confirmIcon: Icons.power_settings_new,
        isDestructive: true,
        onPositiveButtonClick: () {
          homeCubit.powerOff();
          Navigator.pop(dialogContext);
        },
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.accent,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final color = accent ?? AppColors.white.withValues(alpha: 0.7);
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.md + 2),
          ),
          child: Icon(icon, size: 21, color: color),
        ),
      ),
    );
  }
}

/// Internet sharing card backed by the mobile-data toggle.
class _InternetCard extends StatelessWidget {
  const _InternetCard({required this.devices});

  final int devices;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataConnectivityCubit, DataConnectivityState>(
      builder: (context, state) {
        final isOn = state.isMobileDataEnabled;
        final green = AppColors.greenAccent;
        return ToggleCard(
          icon: Icons.wifi_tethering,
          accent: green,
          title: 'Internet',
          subtitle: isOn
              ? 'Connected · sharing to $devices devices'
              : 'Mobile data off',
          subtitleColor: isOn ? green : null,
          value: isOn,
          onChanged: (_) =>
              context.read<DataConnectivityCubit>().toggleMobileData(),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InlineToggleRow(
                icon: Icons.travel_explore,
                title: 'Data roaming',
                subtitle: state.isRoamingEnabled
                    ? 'On'
                    : 'Off · home network only',
                value: state.isRoamingEnabled,
                onChanged: (_) =>
                    context.read<DataConnectivityCubit>().toggleRoaming(),
              ),
              const SizedBox(height: AppSpacing.md),
              NetworkModeSelector(
                selected: state.networkMode,
                enabled: !state.isLoading,
                onChanged: (mode) => context
                    .read<DataConnectivityCubit>()
                    .updateNetworkMode(mode),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DataLimitCard extends StatelessWidget {
  const _DataLimitCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataLimitCubit, DataLimitState>(
      builder: (context, state) {
        final limit = _formatAllowance(state.allowance, state.allowanceUnit);
        final isOn = state.isUsageLimitEnabled;
        return ToggleCard(
          icon: Icons.data_saver_off,
          title: 'Data limit',
          subtitle: isOn ? 'On · cap at $limit' : 'Off · no data cap',
          value: isOn,
          onChanged: (_) => context.read<DataLimitCubit>().toggleLimit(),
          onEdit: () => _showSetLimitDialog(context, state),
          footer: isOn
              ? DataUsageBar(
                  usedBytes: bytesFromDataString(state.totalUsed),
                  limitBytes:
                      state.allowance * state.allowanceUnit.multiplier.toDouble(),
                )
              : null,
        );
      },
    );
  }

  void _showSetLimitDialog(BuildContext context, DataLimitState state) {
    final cubit = context.read<DataLimitCubit>();
    showDialog(
      context: context,
      builder: (_) => _SetDataLimitDialog(
        initialAmount: state.allowance,
        initialUnit: state.allowanceUnit,
        onSave: (amount, unit) {
          cubit.updateAllowance(amount);
          cubit.updateAllowanceUnit(unit);
          // Setting a cap turns the limit on (mirrors the router's set call,
          // which sends dataLimit: true).
          cubit.updateMobileData(true);
          cubit.apply();
        },
      ),
    );
  }
}

/// Amount + unit entry for the monthly data cap. Saving applies it to the
/// router via [DataLimitCubit.apply].
class _SetDataLimitDialog extends StatefulWidget {
  const _SetDataLimitDialog({
    required this.initialAmount,
    required this.initialUnit,
    required this.onSave,
  });

  final int initialAmount;
  final AllowanceUnit initialUnit;
  final void Function(int amount, AllowanceUnit unit) onSave;

  @override
  State<_SetDataLimitDialog> createState() => _SetDataLimitDialogState();
}

class _SetDataLimitDialogState extends State<_SetDataLimitDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialAmount > 0 ? '${widget.initialAmount}' : '',
  );
  late AllowanceUnit _unit = widget.initialUnit;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final amount = int.tryParse(_controller.text.trim());
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Enter an amount greater than 0');
      return;
    }
    widget.onSave(amount, _unit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set data limit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: 'e.g. 5',
              errorText: _error,
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: AppSpacing.md),
          SegmentedButton<AllowanceUnit>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: AllowanceUnit.mb, label: Text('MB')),
              ButtonSegment(value: AllowanceUnit.gb, label: Text('GB')),
            ],
            selected: {_unit},
            onSelectionChanged: (s) => setState(() => _unit = s.first),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}

/// Session traffic from the router's `jsonp_statistics` endpoint — the live
/// speed meter together with download / upload / total figures, all from one
/// API. The speed dial hides when its refresh is set to Off in Settings, but
/// the totals stay visible.
class _TrafficCard extends StatefulWidget {
  const _TrafficCard();

  @override
  State<_TrafficCard> createState() => _TrafficCardState();
}

class _TrafficCardState extends State<_TrafficCard>
    with SingleTickerProviderStateMixin {
  // Peak-hold: the scale only grows during a session so the needle doesn't
  // jitter as the dial rescales under it.
  double _peakBytes = 0;

  // Flashes once per successful poll so the live cadence is visible.
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _confirmReset(BuildContext context) async {
    final cubit = context.read<StatisticsCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => const AppAlertDialog(
        title: 'Reset traffic stats?',
        message: 'This clears the session download, upload and total counters.',
        confirmLabel: 'Reset',
        confirmIcon: Icons.refresh,
      ),
    );
    if (confirmed != true) return;
    final ok = await cubit.clearTraffic();
    messenger.showSnackBar(
      SnackBar(content: Text(ok ? 'Traffic stats reset' : 'Reset failed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listenWhen: (_, current) => current is StatisticsSuccessful,
      listener: (_, _) => _pulse.forward(from: 0),
      builder: (context, state) {
        final stats = state is StatisticsSuccessful ? state.statistics : null;
        final bytes = _speedBytes(stats?.speed);
        if (bytes > _peakBytes) _peakBytes = bytes;
        final maxBytes = _niceMaxBytes(math.max(_peakBytes, _kMinScaleBytes));

        // Stay in KB/s until a transfer pushes the scale into the MB range,
        // then switch the whole dial (value + scale) to MB/s.
        final useMb = maxBytes >= _kBytesPerMb;
        final divisor = useMb ? _kBytesPerMb : _kBytesPerKb;
        final unit = useMb ? 'MB/s' : 'KB/s';

        return SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.insights,
                      size: 18, color: AppColors.blue500),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Traffic',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  _LivePulse(animation: _pulse),
                  const SizedBox(width: AppSpacing.sm),
                  _SmallIconButton(
                    icon: Icons.restart_alt,
                    tooltip: 'Reset stats',
                    onTap: () => _confirmReset(context),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _SmallIconButton(
                    icon: Icons.refresh,
                    tooltip: 'Refresh',
                    onTap: () =>
                        context.read<StatisticsCubit>().fetchStatistics(),
                  ),
                ],
              ),
              // Live speed dial — hidden when speed refresh is Off.
              ValueListenableBuilder<int>(
                valueListenable: PrefsRepository().speedRefreshMs,
                builder: (context, ms, _) {
                  if (ms <= 0) return const SizedBox(height: AppSpacing.lg);
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.sm,
                      bottom: AppSpacing.md,
                    ),
                    child: SpeedGauge(
                      value: bytes / divisor,
                      maxValue: maxBytes / divisor,
                      unit: unit,
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: _TrafficMetric(
                      icon: Icons.south,
                      accent: AppColors.greenAccent,
                      label: 'Download',
                      value: _fmtStat(stats?.download),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _TrafficMetric(
                      icon: Icons.north,
                      accent: AppColors.blue500,
                      label: 'Upload',
                      value: _fmtStat(stats?.upload),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Divider(
                height: 1,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
              const SizedBox(height: AppSpacing.xs),
              _TrafficRow(
                icon: Icons.data_usage,
                label: 'Total this session',
                value: _fmtStat(stats?.total),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Accent-tinted Download / Upload tile inside the traffic card.
class _TrafficMetric extends StatelessWidget {
  const _TrafficMetric({
    required this.icon,
    required this.accent,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color accent;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.md + 1),
        border: Border.all(color: accent.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// A muted label/value row (e.g. Total this session) in the traffic card.
class _TrafficRow extends StatelessWidget {
  const _TrafficRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icon,
            size: 18, color: AppColors.white.withValues(alpha: 0.6)),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}

/// Compact 40×40 icon button used in card headers.
class _SmallIconButton extends StatelessWidget {
  const _SmallIconButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.md + 2),
          ),
          child: Icon(icon,
              size: 19, color: AppColors.white.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}

/// A "LIVE" badge whose dot blinks each time [animation] fires (once per poll).
class _LivePulse extends StatelessWidget {
  const _LivePulse({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final green = AppColors.greenAccent;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            // 1 → 0 over the pulse so the dot flashes bright then settles.
            final t = 1 - animation.value;
            return Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: green.withValues(alpha: 0.35 + 0.65 * t),
                boxShadow: [
                  BoxShadow(color: green.withValues(alpha: t), blurRadius: 6),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'LIVE',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: green.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

const double _kBytesPerKb = 1024;
const double _kBytesPerMb = 1024 * 1024;

/// Idle scale floor (in bytes/s) so the gauge isn't twitchy at low speeds.
const double _kMinScaleBytes = 250 * _kBytesPerKb;

/// Parses a router speed string ("0.0K/s", "536B/s", "1.160MB/s") to bytes/s.
double _speedBytes(String? speed) {
  if (speed == null || speed == cUnknownStr) return 0;
  return bytesFromDataString(speed);
}

/// Rounds [bytes] up to a tidy full-scale value for the dial. The ladder spans
/// KB/s through MB/s so the scale (and unit) track the actual throughput.
double _niceMaxBytes(double bytes) {
  const ladder = <double>[
    100 * _kBytesPerKb,
    250 * _kBytesPerKb,
    500 * _kBytesPerKb,
    1 * _kBytesPerMb,
    2 * _kBytesPerMb,
    5 * _kBytesPerMb,
    10 * _kBytesPerMb,
    20 * _kBytesPerMb,
    50 * _kBytesPerMb,
    100 * _kBytesPerMb,
  ];
  for (final step in ladder) {
    if (bytes <= step) return step;
  }
  return (bytes / (100 * _kBytesPerMb)).ceilToDouble() * 100 * _kBytesPerMb;
}

class _DataUsedTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataLimitCubit, DataLimitState>(
      builder: (context, state) {
        // The router only reports usage against an active cap, so there is
        // nothing meaningful to show when the limit is off.
        final value = !state.isUsageLimitEnabled || state.totalUsed.isEmpty
            ? '—'
            : _clean(state.totalUsed);
        return StatTile(
          icon: Icons.swap_vert,
          value: value,
          label: 'Data used',
        );
      },
    );
  }
}

// --- parsing helpers -------------------------------------------------------

int _batteryPercent(String raw) =>
    int.tryParse(raw.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

String _clean(String raw) => raw == cUnknownStr ? '—' : raw;

String _fmtStat(String? raw) =>
    (raw == null || raw == cUnknownStr) ? '—' : raw;

String _hotspotName(String raw) =>
    (raw == cUnknownStr || raw.isEmpty) ? 'Archer PR71' : raw;

/// `functionTimes` is uptime in seconds when numeric; fall back to a plain
/// "Online" label otherwise.
String _statusLabel(String functionTimes) {
  final seconds = int.tryParse(functionTimes.trim());
  if (seconds == null || seconds <= 0) return 'Online';
  final d = seconds ~/ 86400;
  final h = (seconds % 86400) ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final up = d > 0 ? '${d}d ${h}h' : '${h}h ${m}m';
  return 'Online · up $up';
}

String _formatAllowance(int allowance, AllowanceUnit unit) =>
    '$allowance ${unit.label}';
