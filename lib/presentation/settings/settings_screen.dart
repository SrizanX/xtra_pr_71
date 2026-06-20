import 'package:flutter/material.dart';
import '../../data/shared_preferences/prefs_repository.dart';
import '../../design/design_system.dart';
import '../components/surface_card.dart';
import 'items/refresh_rate/refresh_rate_setting.dart';
import 'items/system_settings.dart';
import 'items/wifi_settings/wifi_settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimensions.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(dimens.screenPadding),
          children: const [
            _SectionLabel("Connection"),
            SurfaceCard(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: WifiSettings(),
            ),
            SizedBox(height: AppSpacing.lg),
            _SectionLabel("Refresh rates"),
            SurfaceCard(child: _RefreshRates()),
            SizedBox(height: AppSpacing.lg),
            _SectionLabel("System"),
            SurfaceCard(child: SystemSettings()),
            SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

/// Muted, spaced-out caption that heads each group of settings cards.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xs,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
              color: AppColors.white.withValues(alpha: 0.5),
            ),
      ),
    );
  }
}

/// Refresh-rate controls for the live speed meter and the home dashboard.
/// Both pause when set to Off, and apply to the running Home cubits live.
class _RefreshRates extends StatelessWidget {
  const _RefreshRates();

  static const _speedOptions = [
    RefreshOption("Off", 0),
    RefreshOption("0.5s", 500),
    RefreshOption("1s", 1000),
    RefreshOption("2s", 2000),
    RefreshOption("5s", 5000),
  ];

  static const _dashboardOptions = [
    RefreshOption("Off", 0),
    RefreshOption("5s", 5000),
    RefreshOption("15s", 15000),
    RefreshOption("30s", 30000),
    RefreshOption("60s", 60000),
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = PrefsRepository();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RefreshRateSetting(
          icon: Icons.speed,
          title: "Network speed",
          subtitle: "Live meter update rate",
          options: _speedOptions,
          valueListenable: prefs.speedRefreshMs,
          onSelected: prefs.setSpeedRefreshMs,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Divider(
            height: 1,
            color: AppColors.white.withValues(alpha: 0.08),
          ),
        ),
        RefreshRateSetting(
          icon: Icons.dashboard_outlined,
          title: "Dashboard data",
          subtitle: "Battery, signal & devices",
          options: _dashboardOptions,
          valueListenable: prefs.dashboardRefreshMs,
          onSelected: prefs.setDashboardRefreshMs,
        ),
      ],
    );
  }
}
