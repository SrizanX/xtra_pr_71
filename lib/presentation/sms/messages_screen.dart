import 'package:flutter/material.dart';

import '../components/app_alert_dialog_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../design/design_system.dart';
import '../../domain/entity/sms/sms.dart';
import '../components/app_error_widget.dart';
import '../components/centered_progress_indicator.dart';
import '../components/surface_card.dart';
import 'bloc/sms_cubit.dart';
import 'bloc/sms_state.dart';
import 'conversation_screen.dart';

/// SMS inbox styled per the PR71 design: messages grouped into conversations
/// by phone number, with an Inbox / Sent filter.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  /// false = Inbox (received), true = Sent.
  bool _showSent = false;

  final _scrollController = ScrollController();

  /// Whether this tab is the visible one. In a [StatefulShellRoute.indexedStack]
  /// the screen stays mounted when you switch tabs, so we track visibility via
  /// [TickerMode] (go_router disables it for off-screen branches) and pause the
  /// SMS background loader while we're hidden.
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final visible = TickerMode.valuesOf(context).enabled;
    if (visible == _visible) return;
    _visible = visible;
    final cubit = context.read<SmsCubit>();
    if (visible) {
      cubit.resumeLoading();
    } else {
      cubit.pauseLoading();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Loads the next page once the user nears the bottom of the list.
  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 400) {
      context.read<SmsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SmsCubit, SmsState>(
          builder: (context, state) {
            return switch (state) {
              Initial() => const CenteredProgressIndicator(),
              SmsListFailed(:final message) => ErrorView(
                errorMessage: message,
                onRetry: () => context.read<SmsCubit>().fetchAllSms(),
              ),
              SmsListSuccessful() => _buildContent(context, state),
            };
          },
        ),
      ),
      // Compose is only meaningful once messages have loaded — hidden while
      // loading or when the router is unreachable.
      floatingActionButton: BlocBuilder<SmsCubit, SmsState>(
        builder: (context, state) => state is SmsListSuccessful
            ? FloatingActionButton(
                onPressed: () => _notSupported(context),
                child: const Icon(Icons.edit),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SmsListSuccessful state) {
    final sms = state.sms;
    final messages = sms.data;
    final byNumber = _groupByNumber(messages);
    final threads = _threadsForTab(byNumber);
    final hasMore = state.loadedPage < state.totalPage;

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xxxl,
      ),
      children: [
        _Header(
          total: sms.totalRecords,
          onRefresh: () => context.read<SmsCubit>().fetchAllSms(),
        ),
        const SizedBox(height: AppSpacing.lg),
        _QuickActions(
          onUssd: () => context.push('/messages/ussd'),
        ),
        const SizedBox(height: AppSpacing.lg),
        _InboxSentToggle(
          // Count conversations (threads), matching the rows shown below —
          // not raw messages, which would over-count grouped numbers.
          inboxCount: _threadCount(byNumber, sent: false),
          sentCount: _threadCount(byNumber, sent: true),
          // Counts are still climbing while pages load in the background.
          isLoading: hasMore,
          showSent: _showSent,
          onChanged: (sent) => setState(() => _showSent = sent),
        ),
        const SizedBox(height: AppSpacing.md),
        if (threads.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
            child: Center(
              child: Text(
                _showSent ? 'No sent messages' : 'No messages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          )
        else
          SurfaceCard(
            padding: EdgeInsets.zero,
            borderRadius: AppRadius.md + 2,
            child: Column(
              children: [
                for (var i = 0; i < threads.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.white.withValues(alpha: 0.06),
                    ),
                  _ThreadTile(
                    thread: threads[i],
                    allForNumber: byNumber[threads[i].phoneNumber]!,
                  ),
                ],
              ],
            ),
          ),
        if (hasMore)
          const Padding(
            padding: EdgeInsets.only(top: AppSpacing.lg),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }

  /// Threads for the active tab: only messages of the selected direction,
  /// grouped by number, newest first.
  List<_Thread> _threadsForTab(Map<String, List<Sms>> byNumber) {
    final threads = <_Thread>[];
    byNumber.forEach((number, all) {
      final inTab = all.where((m) => m.isSent == _showSent).toList();
      if (inTab.isEmpty) return;
      inTab.sort(_byDateDesc);
      threads.add(_Thread(phoneNumber: number, latest: inTab.first));
    });
    threads.sort((a, b) => _byDateDesc(a.latest, b.latest));
    return threads;
  }

  /// Number of conversations that contain at least one message in the given
  /// direction — i.e. how many tiles that tab shows.
  int _threadCount(Map<String, List<Sms>> byNumber, {required bool sent}) =>
      byNumber.values.where((all) => all.any((m) => m.isSent == sent)).length;

  Map<String, List<Sms>> _groupByNumber(List<Sms> messages) {
    final map = <String, List<Sms>>{};
    for (final sms in messages) {
      map.putIfAbsent(sms.phoneNumber, () => []).add(sms);
    }
    return map;
  }

  void _notSupported(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sending SMS isn\'t supported on this device yet.'),
      ),
    );
  }

}

int _byDateDesc(Sms a, Sms b) {
  final da = a.sentAt, db = b.sentAt;
  if (da == null || db == null) return 0;
  return db.compareTo(da);
}

class _Thread {
  const _Thread({required this.phoneNumber, required this.latest});

  final String phoneNumber;
  final Sms latest;
}

class _Header extends StatelessWidget {
  const _Header({required this.total, required this.onRefresh});

  final int total;
  final VoidCallback onRefresh;

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
                'Messages',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'SIM storage · $total ${total == 1 ? 'message' : 'messages'}',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onRefresh,
          borderRadius: BorderRadius.circular(AppRadius.md + 2),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.md + 2),
            ),
            child: Icon(
              Icons.refresh,
              size: 21,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onUssd});

  final VoidCallback onUssd;

  @override
  Widget build(BuildContext context) {
    return _QuickAction(
      icon: Icons.dialpad,
      title: 'USSD',
      subtitle: 'Run a code',
      accent: AppColors.blue500,
      onTap: onUssd,
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = accent ?? AppColors.white.withValues(alpha: 0.7);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md + 2),
      child: SurfaceCard(
        borderRadius: AppRadius.md + 2,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        gradientColors: accent == null
            ? null
            : [
                accent!.withValues(alpha: 0.1),
                AppColors.white.withValues(alpha: 0.04),
              ],
        borderColor: accent?.withValues(alpha: 0.22),
        child: Row(
          children: [
            Icon(icon, color: color, size: 21),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InboxSentToggle extends StatelessWidget {
  const _InboxSentToggle({
    required this.inboxCount,
    required this.sentCount,
    required this.isLoading,
    required this.showSent,
    required this.onChanged,
  });

  final int inboxCount;
  final int sentCount;
  final bool isLoading;
  final bool showSent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs + 1),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md + 3),
      ),
      child: Row(
        children: [
          _segment(
            'Inbox',
            inboxCount,
            selected: !showSent,
            onTap: () => onChanged(false),
          ),
          _segment(
            'Sent',
            sentCount,
            selected: showSent,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }

  Widget _segment(
    String label,
    int count, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    final textColor = selected
        ? AppColors.white
        : AppColors.white.withValues(alpha: 0.55);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 1),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.blue500
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md - 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: label,
                  children: [
                    TextSpan(
                      text: '  $count',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.white.withValues(
                          alpha: selected ? 0.85 : 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              // While more pages load, the count is still climbing.
              if (isLoading) ...[
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 11,
                  height: 11,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.6,
                    color: textColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.thread, required this.allForNumber});

  final _Thread thread;
  final List<Sms> allForNumber;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context.push(
        ConversationScreen.route,
        extra: ConversationArgs(
          phoneNumber: thread.phoneNumber,
          messages: allForNumber,
        ),
      ),
      onLongPress: () => _confirmDelete(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + 1,
        ),
        child: Row(
          children: [
            _Avatar(label: _initials(thread.phoneNumber)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.phoneNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        formatSmsTime(thread.latest.sentAt),
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.blue500.withValues(
                            alpha: 0.8,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    thread.latest.smsContent,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String number) {
    final cleaned = number.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (cleaned.isEmpty) return '#';
    return cleaned.length <= 4
        ? cleaned
        : cleaned.substring(cleaned.length - 2);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final count = allForNumber.length;
    final cubit = context.read<SmsCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppAlertDialog(
        title: 'Delete conversation?',
        message: 'Delete all $count ${count == 1 ? 'message' : 'messages'} '
            'with ${thread.phoneNumber}? This removes them from the SIM.',
        confirmLabel: 'Delete',
        confirmIcon: Icons.delete_outline,
        isDestructive: true,
      ),
    );
    if (confirmed != true) return;
    final ok = await cubit.deleteMessages(allForNumber);
    messenger.showSnackBar(
      SnackBar(content: Text(ok ? 'Conversation deleted' : 'Delete failed')),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.blue500.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: label.length > 2 ? 12 : 15,
          fontWeight: FontWeight.w700,
          color: AppColors.blueLight,
        ),
      ),
    );
  }
}

/// Shared SMS timestamp formatter: time for today, day+month for this year,
/// else a short date.
String formatSmsTime(DateTime? date) {
  if (date == null) return '';
  final now = DateTime.now();
  final isToday =
      date.year == now.year && date.month == now.month && date.day == now.day;
  if (isToday) return DateFormat('h:mm a').format(date);
  if (date.year == now.year) return DateFormat('d MMM').format(date);
  return DateFormat('d/M/yy').format(date);
}
