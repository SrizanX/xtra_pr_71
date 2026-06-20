import 'package:flutter/material.dart';
import 'package:xtra_pr_71/design/design_system.dart';

/// Play Store feature graphic (1024×500): brand wordmark + tagline + feature
/// pills on the left, the glowing router hero on the right, over the app's dark
/// navy with a blue glow — consistent with the login/splash hero.
class FeatureGraphic extends StatelessWidget {
  const FeatureGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    const blue = AppColors.blue500;
    return SizedBox(
      width: 1024,
      height: 500,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff343859), AppColors.darkBlue],
          ),
        ),
        child: Stack(
          children: [
            // Soft blue glow bleeding from behind the hero art.
            Positioned(
              right: 70,
              top: 110,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blue.withValues(alpha: 0.35),
                      blurRadius: 120,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 48, 56, 48),
              child: Row(
                children: [
                  const Expanded(child: _LeftBlock()),
                  const SizedBox(width: 28),
                  const _HeroArt(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftBlock extends StatelessWidget {
  const _LeftBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.wifi_tethering,
                size: 22, color: AppColors.greenAccent.withValues(alpha: 0.9)),
            const SizedBox(width: 10),
            Text(
              'ROUTER COMPANION',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
                color: AppColors.white.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'XTRA PR71',
          style: TextStyle(
            fontSize: 66,
            fontWeight: FontWeight.w800,
            height: 1.0,
            color: AppColors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Your pocket router, fully in control.',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: AppColors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _Pill(icon: Icons.speed, label: 'Live speed', accent: AppColors.greenAccent),
            _Pill(icon: Icons.data_saver_off, label: 'Data limits', accent: AppColors.blue500),
            _Pill(icon: Icons.sms_outlined, label: 'SMS & USSD', accent: AppColors.amber),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, required this.accent});

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: accent.withValues(alpha: 0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: accent),
          const SizedBox(width: 9),
          Text(
            label,
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
              color: AppColors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}

/// The router glyph in a glowing blue gradient tile, framed by two faint accent
/// rings that echo the dashboard gauges.
class _HeroArt extends StatelessWidget {
  const _HeroArt();

  @override
  Widget build(BuildContext context) {
    const blue = AppColors.blue500;
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(290, AppColors.greenAccent.withValues(alpha: 0.18)),
          _ring(234, blue.withValues(alpha: 0.35)),
          Container(
            width: 168,
            height: 168,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  blue.withValues(alpha: 0.55),
                  blue.withValues(alpha: 0.18),
                ],
              ),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: blue.withValues(alpha: 0.6), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: blue.withValues(alpha: 0.5),
                  blurRadius: 48,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: const Icon(Icons.router, size: 92, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _ring(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
      );
}
