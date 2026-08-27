sealed class SendSmsState {}

/// Nothing being sent (initial, or after a success/failure is acknowledged).
class SendSmsIdle extends SendSmsState {}

/// A send is in flight — [status] describes the phase (sending / confirming).
class SendSmsInProgress extends SendSmsState {
  final String status;

  SendSmsInProgress({required this.status});
}

/// The message was accepted and confirmed sent. Carries the destination and
/// body so the UI can show it in the thread without a full reload.
class SendSmsSuccess extends SendSmsState {
  final String number;
  final String content;

  SendSmsSuccess({required this.number, required this.content});
}

class SendSmsFailure extends SendSmsState {
  final String message;

  SendSmsFailure({required this.message});
}
