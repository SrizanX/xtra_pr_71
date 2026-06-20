sealed class UssdState {}

/// Nothing dialed yet (or after a cancel/reset).
class UssdIdle extends UssdState {}

/// A request is in flight — [status] describes the phase (dialing / waiting).
class UssdInProgress extends UssdState {
  final String status;

  UssdInProgress({required this.status});
}

/// The network returned a response.
class UssdSuccess extends UssdState {
  final String response;

  UssdSuccess({required this.response});
}

class UssdFailure extends UssdState {
  final String message;

  UssdFailure({required this.message});
}
