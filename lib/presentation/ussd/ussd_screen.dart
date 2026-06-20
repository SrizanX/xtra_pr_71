import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/api/dashboard_api_service.dart';
import '../../design/design_system.dart';
import '../../domain/entity/device_info.dart';
import '../../domain/entity/operator/mobile_operator.dart';
import '../../domain/result.dart';
import '../components/surface_card.dart';
import 'bloc/ussd_cubit.dart';
import 'bloc/ussd_state.dart';
import 'ussd_quick_codes.dart';

/// USSD runner: submit a code, then show the network's response with the
/// option to reply (for interactive menus).
class UssdScreen extends StatefulWidget {
  const UssdScreen({super.key});

  @override
  State<UssdScreen> createState() => _UssdScreenState();
}

class _UssdScreenState extends State<UssdScreen> {
  final _codeController = TextEditingController();
  final _replyController = TextEditingController();

  /// Operator detected from the SIM's IMSI, used to pick the quick codes.
  MobileOperator _operator = MobileOperator.unknown;

  @override
  void initState() {
    super.initState();
    _detectOperator();
  }

  Future<void> _detectOperator() async {
    final result = await DashboardApiService().fetchDashboardData();
    if (!mounted) return;
    if (result is Successful<DeviceInfo>) {
      setState(() => _operator = MobileOperator.fromImsi(result.data.imsi));
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _replyController.dispose();
    super.dispose();
  }

  void _dial(String code) {
    _codeController.text = code;
    FocusScope.of(context).unfocus();
    context.read<UssdCubit>().dial(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            _Header(),
            const SizedBox(height: AppSpacing.lg),
            const _SectionLabel('Run a code'),
            _CodeInput(controller: _codeController, onDial: () => _dial(_codeController.text)),
            _ResponseSection(
              replyController: _replyController,
              onSendReply: () {
                final reply = _replyController.text.trim();
                if (reply.isEmpty) return;
                FocusScope.of(context).unfocus();
                context.read<UssdCubit>().dial(reply);
                _replyController.clear();
              },
              onCancel: () {
                _replyController.clear();
                context.read<UssdCubit>().reset();
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionLabel(
              _operator.isKnown
                  ? 'Quick codes · ${_operator.displayName}'
                  : 'Quick codes',
            ),
            _CodeListCard(codes: quickCodesFor(_operator), onDial: _dial),
            const SizedBox(height: AppSpacing.lg),
            const _SectionLabel('Mobile banking'),
            _CodeListCard(codes: mfsCodes, onDial: _dial),
          ],
        ),
      ),
    );
  }
}

/// A card listing tappable quick codes, divided into rows.
class _CodeListCard extends StatelessWidget {
  const _CodeListCard({required this.codes, required this.onDial});

  final List<QuickCode> codes;
  final void Function(String code) onDial;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.zero,
      borderRadius: AppRadius.md + 2,
      child: Column(
        children: [
          for (var i = 0; i < codes.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.white.withValues(alpha: 0.06),
              ),
            _QuickCodeTile(
              icon: codes[i].icon,
              label: codes[i].label,
              code: codes[i].code,
              onTap: () => onDial(codes[i].code),
            ),
          ],
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: AppColors.white.withValues(alpha: 0.7),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          'USSD',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.sm),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: AppColors.white.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  const _CodeInput({required this.controller, required this.onDial});

  final TextEditingController controller;
  final VoidCallback onDial;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      borderRadius: AppRadius.md + 2,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: AppColors.white,
              ),
              decoration: InputDecoration.collapsed(
                hintText: '*123#',
                hintStyle: TextStyle(
                  fontSize: 22,
                  color: AppColors.white.withValues(alpha: 0.35),
                ),
              ),
              onSubmitted: (_) => onDial(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton.icon(
            onPressed: onDial,
            icon: const Icon(Icons.call, size: 18),
            label: const Text('Dial'),
          ),
        ],
      ),
    );
  }
}

class _QuickCodeTile extends StatelessWidget {
  const _QuickCodeTile({
    required this.icon,
    required this.label,
    required this.code,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String code;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + 1,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.blue500),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              code,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseSection extends StatelessWidget {
  const _ResponseSection({
    required this.replyController,
    required this.onSendReply,
    required this.onCancel,
  });

  final TextEditingController replyController;
  final VoidCallback onSendReply;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UssdCubit, UssdState>(
      builder: (context, state) {
        if (state is UssdIdle) return const SizedBox.shrink();
        // Sits directly under the code input; gap collapses when idle.
        return Padding(
          padding: const EdgeInsets.only(top: AppSpacing.lg),
          child: switch (state) {
            UssdIdle() => const SizedBox.shrink(),
            UssdInProgress(:final status) => _StatusCard(status: status),
            UssdFailure(:final message) => _MessageCard(
                text: message,
                accent: Theme.of(context).colorScheme.error,
              ),
            UssdSuccess(:final response) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionLabel('Last response'),
                  _ResponseCard(
                    response: response,
                    replyController: replyController,
                    onSendReply: onSendReply,
                    onCancel: onCancel,
                  ),
                ],
              ),
          },
        );
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      borderRadius: AppRadius.md + 2,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            status,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.text, required this.accent});

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      borderRadius: AppRadius.md + 2,
      borderColor: accent.withValues(alpha: 0.4),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: accent, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  const _ResponseCard({
    required this.response,
    required this.replyController,
    required this.onSendReply,
    required this.onCancel,
  });

  final String response;
  final TextEditingController replyController;
  final VoidCallback onSendReply;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      borderRadius: AppRadius.md + 2,
      gradientColors: [
        AppColors.blue500.withValues(alpha: 0.12),
        AppColors.white.withValues(alpha: 0.04),
      ],
      borderColor: AppColors.blue500.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            response,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.06),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: TextField(
                    controller: replyController,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Reply…',
                      hintStyle: TextStyle(
                        color:
                            AppColors.white.withValues(alpha: 0.45),
                      ),
                    ),
                    onSubmitted: (_) => onSendReply(),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              FilledButton(onPressed: onSendReply, child: const Text('Send')),
              const SizedBox(width: AppSpacing.xs),
              TextButton(onPressed: onCancel, child: const Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}
