sealed class Result<T> {
  const Result();
}

final class Successful<T> extends Result<T> {
  final T data;

  const Successful({required this.data});
}

final class Failed<T> extends Result<T> {
  final String message;
  final Exception? exception;

  /// Classification of the failure so the UI can react appropriately (e.g.
  /// guide the user to reconnect vs. switch networks). Defaults to [unknown]
  /// for non-transport failures (parsing, validation, …).
  final NetworkFailure kind;

  const Failed({
    required this.message,
    this.exception,
    this.kind = NetworkFailure.unknown,
  });
}

/// Why a router request failed, at the transport level.
enum NetworkFailure {
  /// Nothing answered at the router's address: Wi-Fi is off, the phone is on a
  /// different network, or the router is rebooting / powered off.
  unreachable,

  /// Something answered, but it isn't the PR71 — a different router at the same
  /// LAN address (401/403, or a non-router response).
  wrongDevice,

  /// Anything else (HTTP error, unexpected/unparseable payload, …).
  unknown;

  /// A user-facing message suitable for a toast or error screen.
  String get message => switch (this) {
        NetworkFailure.unreachable =>
          "Can't reach the router. Make sure your phone is connected to its "
              "Wi-Fi.",
        NetworkFailure.wrongDevice =>
          "Connected to a different router. Switch to the PR71's Wi-Fi network.",
        NetworkFailure.unknown => "Something went wrong. Please try again.",
      };
}
