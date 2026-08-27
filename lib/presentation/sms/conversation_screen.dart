import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../design/design_system.dart';
import '../../domain/entity/sms/sms.dart';
import 'bloc/send_sms_cubit.dart';
import 'bloc/send_sms_state.dart';
import 'messages_screen.dart' show formatSmsTime;
import 'sms_validation.dart';

/// Arguments passed to [ConversationScreen] via the router's `extra`.
class ConversationArgs {
  const ConversationArgs({required this.phoneNumber, required this.messages});

  final String phoneNumber;
  final List<Sms> messages;
}

/// A single SMS thread rendered as a chat conversation.
///
/// Replies are sent through [SendSmsCubit] (the router's two-step send). A
/// confirmed message is appended to the thread optimistically so it appears
/// immediately, without waiting for the next full inbox reload.
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.args});

  static const String route = '/conversation';

  final ConversationArgs args;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _controller = TextEditingController();

  /// Messages sent from this screen, kept locally so a confirmed send shows in
  /// the thread right away (the inbox is only re-fetched on the Messages tab).
  final _sent = <Sms>[];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<SendSmsCubit>().send(widget.args.phoneNumber, text);
  }

  void _onSendResult(BuildContext context, SendSmsState state) {
    if (state is SendSmsSuccess) {
      setState(() => _sent.add(_optimisticSms(state.number, state.content)));
      _controller.clear();
      context.read<SendSmsCubit>().reset();
    } else if (state is SendSmsFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(state.message)));
      context.read<SendSmsCubit>().reset();
    }
  }

  /// A locally-built "sent" message for immediate display. `smstype: '2'` marks
  /// it as outgoing (see [SmsDirection.isSent]); the negative id keeps it from
  /// colliding with real router message ids.
  Sms _optimisticSms(String number, String content) => Sms(
        smsContent: content,
        phoneNumber: number,
        smsDate: DateTime.now().toIso8601String(),
        messageid: -DateTime.now().millisecondsSinceEpoch,
        classid: 0,
        singleCount: '1',
        smstype: '2',
      );

  @override
  Widget build(BuildContext context) {
    final messages = [...widget.args.messages, ..._sent]
      ..sort((a, b) => (a.sentAt ?? DateTime(0)).compareTo(b.sentAt ?? DateTime(0)));
    final items = _withDateSeparators(messages);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _ConversationHeader(phoneNumber: widget.args.phoneNumber),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return item is String
                      ? _DaySeparator(label: item)
                      : _Bubble(sms: item as Sms);
                },
              ),
            ),
            BlocConsumer<SendSmsCubit, SendSmsState>(
              listener: _onSendResult,
              builder: (context, state) => _Composer(
                controller: _controller,
                isSending: state is SendSmsInProgress,
                onSend: () => _send(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Interleaves day-separator strings between messages from different days.
  List<Object> _withDateSeparators(List<Sms> messages) {
    final items = <Object>[];
    DateTime? lastDay;
    for (final sms in messages) {
      final date = sms.sentAt;
      if (date != null) {
        final day = DateTime(date.year, date.month, date.day);
        if (lastDay == null || day != lastDay) {
          items.add(_dayLabel(day));
          lastDay = day;
        }
      }
      items.add(sms);
    }
    return items;
  }

  String _dayLabel(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat('d MMMM y').format(day);
  }
}

class _ConversationHeader extends StatelessWidget {
  const _ConversationHeader({required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: onSurface.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: onSurface.withValues(alpha: 0.7),
          ),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.greenAccent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppRadius.md + 1),
            ),
            child: Icon(Icons.person, color: AppColors.greenAccent),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              phoneNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Calling isn\'t supported here.')),
            ),
            icon: const Icon(Icons.call),
            color: AppColors.blue500,
          ),
        ],
      ),
    );
  }
}

class _DaySeparator extends StatelessWidget {
  const _DaySeparator({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface
                .withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.sms});

  final Sms sms;

  @override
  Widget build(BuildContext context) {
    final isSent = sms.isSent;
    final colorScheme = Theme.of(context).colorScheme;
    // The sent bubble is always a solid blue fill, so its text/time need the
    // fixed on-primary color; the received bubble tints with the surface, so
    // its text/time need to track onSurface to stay legible in both themes.
    final bubbleTextColor = isSent ? colorScheme.onPrimary : colorScheme.onSurface;
    final time = formatSmsTime(sms.sentAt);
    const tail = Radius.circular(5);
    final radius = isSent
        ? const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.lg),
            topRight: Radius.circular(AppRadius.lg),
            bottomLeft: Radius.circular(AppRadius.lg),
            bottomRight: tail,
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(AppRadius.lg),
            topRight: Radius.circular(AppRadius.lg),
            bottomLeft: tail,
            bottomRight: Radius.circular(AppRadius.lg),
          );

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md + 2,
          vertical: AppSpacing.sm + 3,
        ),
        decoration: BoxDecoration(
          color: isSent
              ? AppColors.blue500
              : colorScheme.onSurface.withValues(alpha: 0.07),
          borderRadius: radius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sms.smsContent,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: bubbleTextColor,
              ),
            ),
            const SizedBox(height: AppSpacing.xs + 1),
            Text(
              isSent ? '$time · Sent' : time,
              style: TextStyle(
                fontSize: 10,
                color: bubbleTextColor.withValues(alpha: isSent ? 0.7 : 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.onSend,
    this.isSending = false,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    final length = controller.text.characters.length;
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;
    final canSend = !isSending && length > 0;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: onSurface.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm + 2,
              ),
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.06),
                border: Border.all(
                  color: onSurface.withValues(alpha: 0.09),
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg + 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: smsMaxLength,
                    // The manual counter below replaces the built-in one, which
                    // the collapsed decoration wouldn't show anyway.
                    buildCounter: (_, {
                      required currentLength,
                      required isFocused,
                      maxLength,
                    }) => null,
                    style: TextStyle(
                      fontSize: 14,
                      color: onSurface,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Message',
                      hintStyle: TextStyle(
                        color: onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  if (length > 0) ...[
                    const SizedBox(height: AppSpacing.xs + 1),
                    Text(
                      '$length / $smsMaxLength',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm + 2),
          GestureDetector(
            onTap: canSend ? onSend : null,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                // Dim the button while a send is in flight or the field is
                // empty, so it reads as disabled.
                color: AppColors.blue500.withValues(alpha: canSend ? 1 : 0.5),
                shape: BoxShape.circle,
              ),
              child: isSending
                  ? Padding(
                      padding: const EdgeInsets.all(13),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor:
                            AlwaysStoppedAnimation(colorScheme.onPrimary),
                      ),
                    )
                  : Icon(Icons.send, color: colorScheme.onPrimary, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
