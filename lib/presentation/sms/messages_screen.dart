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
import 'bloc/send_sms_cubit.dart';
import 'bloc/send_sms_state.dart';
import 'bloc/sms_cubit.dart';
import 'bloc/sms_state.dart';
import 'conversation_screen.dart';
import 'sms_validation.dart';

/// SMS inbox styled per the PR71 design: messages grouped into conversations
/// by phone number, with an Inbox / Sent filter.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  /// false = Inbox (received), true = Sent.

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
                onPressed: () => _openCompose(context),
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
        // Inbox/Sent toggle is hidden until sent-message caching lands; the
        // router only returns received messages, so we show those for now.
        if (threads.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
            child: Center(
              child: Text(
                'No messages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06),
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

  /// Received-message threads, grouped by number, newest first. (Sent messages
  /// are not persisted yet, so only the inbox is shown — see the hidden toggle.)
  List<_Thread> _threadsForTab(Map<String, List<Sms>> byNumber) {
    final threads = <_Thread>[];
    byNumber.forEach((number, all) {
      final inTab = all.where((m) => !m.isSent).toList();
      if (inTab.isEmpty) return;
      inTab.sort(_byDateDesc);
      threads.add(_Thread(phoneNumber: number, latest: inTab.first));
    });
    threads.sort((a, b) => _byDateDesc(a.latest, b.latest));
    return threads;
  }

  Map<String, List<Sms>> _groupByNumber(List<Sms> messages) {
    final map = <String, List<Sms>>{};
    for (final sms in messages) {
      map.putIfAbsent(sms.phoneNumber, () => []).add(sms);
    }
    return map;
  }

  /// Opens the "new message" composer as a modal bottom sheet. Its own
  /// [SendSmsCubit] drives the send; on success the inbox is reloaded so the
  /// new message appears in a thread.
  void _openCompose(BuildContext context) {
    final smsCubit = context.read<SmsCubit>();
    showModalBottomSheet(
      context: context,
      // Lets the sheet grow and ride above the keyboard.
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider(
        create: (_) => SendSmsCubit(),
        child: _ComposeSheet(onSent: smsCubit.fetchAllSms),
      ),
    );
  }
}

/// A "new message" composer bottom sheet: a recipient number, the message body,
/// and a send button that reflects the two-step send progress. Closes on
/// success.
class _ComposeSheet extends StatefulWidget {
  const _ComposeSheet({required this.onSent});

  /// Called after a message is confirmed sent (used to reload the inbox).
  final VoidCallback onSent;

  @override
  State<_ComposeSheet> createState() => _ComposeSheetState();
}

class _ComposeSheetState extends State<_ComposeSheet> {
  final _number = TextEditingController();
  final _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    _number.addListener(() => setState(() {}));
    _message.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _number.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendSmsCubit, SendSmsState>(
      listener: (context, state) {
        if (state is SendSmsSuccess) {
          widget.onSent();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Message sent to ${state.number}')),
          );
        } else if (state is SendSmsFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
          context.read<SendSmsCubit>().reset();
        }
      },
      builder: (context, state) {
        final sending = state is SendSmsInProgress;
        // Only surface the number error once the user has typed something, so
        // the field doesn't start out red.
        final numberError = _number.text.trim().isEmpty
            ? null
            : validateBdPhone(_number.text);
        final canSend = !sending &&
            isValidBdPhone(_number.text) &&
            _message.text.trim().isNotEmpty;
        return Padding(
          // Lift the sheet above the keyboard.
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'New message',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: _number,
                    enabled: !sending,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'To',
                      prefixIcon: const Icon(Icons.person_outline),
                      errorText: numberError,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _message,
                    enabled: !sending,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: smsMaxLength,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      hintText: 'Type a message',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: canSend
                          ? () => context
                              .read<SendSmsCubit>()
                              .send(_number.text, _message.text)
                          : null,
                      icon: sending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.2),
                            )
                          : const Icon(Icons.send, size: 18),
                      label: Text(sending ? state.status : 'Send'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.md + 2),
            ),
            child: Icon(
              Icons.refresh,
              size: 21,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
    final color = accent ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);
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
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04),
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
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
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
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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
