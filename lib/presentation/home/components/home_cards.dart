import 'package:flutter/material.dart';

import '../../../design/design_system.dart';
import '../../../domain/entity/network_mode.dart';
import '../../components/surface_card.dart';
import 'radial_gauge.dart';

/// A [RadialGauge] in a card with a title and supporting line beneath it.
/// Used for the Battery and Signal gauges in the Home header.
class GaugeCard extends StatelessWidget {
  const GaugeCard({
    super.key,
    required this.progress,
    required this.accent,
    required this.icon,
    required this.value,
    required this.title,
    required this.subtitle,
    this.centerText,
  });

  final double progress;
  final Color accent;
  final IconData icon;
  final int value;
  final String title;
  final String subtitle;

  /// When set, the gauge centre shows this text (with [icon]) instead of the
  /// numeric "value%" readout — used for non-numeric states like "no SIM".
  final String? centerText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SurfaceCard(
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.sm,
      ),
      child: Column(
        children: [
          RadialGauge(
            progress: progress,
            color: accent,
            center: centerText == null
                ? GaugeReadout(icon: icon, value: value, accent: accent)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: accent, size: 22),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        centerText!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

/// A compact metric tile: accent icon, large value, muted label.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final card = SurfaceCard(
      borderRadius: AppRadius.md + 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.blue500, size: 20),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md + 2),
      child: card,
    );
  }
}

/// A row card with an optional leading icon, a title/subtitle, and a trailing
/// switch. Backs the Internet, Roaming and Data-limit controls on Home.
class ToggleCard extends StatelessWidget {
  const ToggleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.icon,
    this.accent,
    this.subtitleColor,
    this.onLongPress,
    this.onEdit,
    this.footer,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;

  /// When set, the card gets a tinted accent gradient/border and icon chip.
  final Color? accent;
  final Color? subtitleColor;
  final VoidCallback? onLongPress;

  /// When set, shows a pencil button (and the long-press also triggers it) for
  /// editing the value behind the toggle.
  final VoidCallback? onEdit;

  /// Optional content rendered below the toggle row, inside the same card
  /// (separated by a divider). Used for the Internet network-mode selector.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = accent;
    return GestureDetector(
      onLongPress: onLongPress ?? onEdit,
      child: SurfaceCard(
        gradientColors: accentColor == null
            ? null
            : [
                accentColor.withValues(alpha: 0.12),
                AppColors.white.withValues(alpha: 0.04),
              ],
        borderColor: accentColor?.withValues(alpha: 0.22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  _IconChip(icon: icon!, accent: accentColor),
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: subtitleColor ??
                              AppColors.white
                                  .withValues(alpha: 0.45),
                          fontWeight:
                              subtitleColor != null ? FontWeight.w600 : null,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onEdit != null)
                  IconButton(
                    onPressed: onEdit,
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Set limit',
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                Switch(value: value, onChanged: onChanged),
              ],
            ),
            if (footer != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Divider(
                  height: 1,
                  color: AppColors.white.withValues(alpha: 0.08),
                ),
              ),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}

/// A lightweight toggle row (icon, label, subtitle, switch) for secondary
/// controls nested inside a larger card — e.g. Data roaming inside Internet.
class InlineToggleRow extends StatelessWidget {
  const InlineToggleRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.white.withValues(alpha: 0.7),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

/// Segmented pill selector for the preferred mobile network (2G / 3G / 4G).
/// Each segment shows the short label with the full coverage as a caption, so
/// the user understands that "4G" still falls back to 3G/2G.
class NetworkModeSelector extends StatelessWidget {
  const NetworkModeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    this.enabled = true,
    this.accent,
  });

  final NetworkMode selected;
  final ValueChanged<NetworkMode> onChanged;
  final bool enabled;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = accent ?? AppColors.blue500;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.network_cell,
              size: 16,
              color: AppColors.white.withValues(alpha: 0.6),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Network mode',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.white.withValues(alpha: 0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Opacity(
          opacity: enabled ? 1 : 0.4,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xxs),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                for (final mode in NetworkMode.values)
                  Expanded(
                    child: _NetworkSegment(
                      mode: mode,
                      isSelected: mode == selected,
                      accent: accentColor,
                      onTap: enabled ? () => onChanged(mode) : null,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NetworkSegment extends StatelessWidget {
  const _NetworkSegment({
    required this.mode,
    required this.isSelected,
    required this.accent,
    required this.onTap,
  });

  final NetworkMode mode;
  final bool isSelected;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedColor =
        isSelected ? accent : AppColors.white.withValues(alpha: 0.7);
    return Tooltip(
      message: mode.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? accent.withValues(alpha: 0.18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: isSelected
                  ? accent.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              mode.shortLabel,
              style: textTheme.labelLarge?.copyWith(
                color: selectedColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  const _IconChip({required this.icon, this.accent});

  final IconData icon;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final color = accent ?? AppColors.white.withValues(alpha: 0.7);
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: (accent ?? AppColors.white)
            .withValues(alpha: accent == null ? 0.06 : 0.16),
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

/// Usage progress against the configured data cap, rendered as the footer of
/// the Data limit card. Inputs are in bytes so that mixed router units
/// (KB / MB / GB) compare correctly.
class DataUsageBar extends StatelessWidget {
  const DataUsageBar({
    super.key,
    required this.usedBytes,
    required this.limitBytes,
  });

  final double usedBytes;
  final double limitBytes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = AppColors.white.withValues(alpha: 0.5);
    final fraction =
        limitBytes <= 0 ? 0.0 : (usedBytes / limitBytes).clamp(0.0, 1.0);
    final remaining =
        limitBytes <= 0 ? 0.0 : (limitBytes - usedBytes).clamp(0.0, limitBytes);
    final nearCap = fraction >= 0.9;
    final barColor = nearCap
        ? Theme.of(context).colorScheme.error
        : AppColors.blue500;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${formatBytes(usedBytes)} of ${formatBytes(limitBytes)} used',
              style: textTheme.bodySmall?.copyWith(color: muted),
            ),
            Text(
              '${formatBytes(remaining)} left',
              style: textTheme.bodySmall?.copyWith(
                color: nearCap ? barColor : muted,
                fontWeight: nearCap ? FontWeight.w700 : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 8,
            backgroundColor: AppColors.white.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation(barColor),
          ),
        ),
      ],
    );
  }
}

/// Formats a byte count into the largest sensible unit (KB / MB / GB).
String formatBytes(double bytes) {
  const kb = 1024.0;
  const mb = kb * 1024;
  const gb = mb * 1024;
  if (bytes >= gb) return '${(bytes / gb).toStringAsFixed(2)} GB';
  if (bytes >= mb) return '${(bytes / mb).toStringAsFixed(2)} MB';
  if (bytes >= kb) return '${(bytes / kb).toStringAsFixed(1)} KB';
  return '${bytes.toStringAsFixed(0)} B';
}

/// Parses a router data string like "667.399KB", "2.017MB", "5.000GB" or
/// "0.0K" into a byte count, tolerating the unit variations the router emits.
double bytesFromDataString(String s) {
  final value = double.tryParse(s.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
  final unit = s.toUpperCase();
  if (unit.contains('G')) return value * 1024 * 1024 * 1024;
  if (unit.contains('M')) return value * 1024 * 1024;
  if (unit.contains('K')) return value * 1024;
  return value;
}
