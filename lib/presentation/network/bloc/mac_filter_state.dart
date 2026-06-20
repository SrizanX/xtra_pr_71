class MacFilterState {
  /// True once the first fetch has completed (controls the loading spinner).
  final bool isReady;

  /// True while a fetch or apply request is in flight.
  final bool isBusy;
  final bool denyEnabled;
  final List<String> macs;
  final bool issim;

  /// One-shot user message (e.g. "List is full"); cleared after it's shown.
  final String? message;

  const MacFilterState({
    this.isReady = false,
    this.isBusy = false,
    this.denyEnabled = false,
    this.macs = const [],
    this.issim = false,
    this.message,
  });

  bool contains(String mac) =>
      macs.any((m) => m.toLowerCase() == mac.toLowerCase());

  MacFilterState copyWith({
    bool? isReady,
    bool? isBusy,
    bool? denyEnabled,
    List<String>? macs,
    bool? issim,
    String? message,
  }) {
    return MacFilterState(
      isReady: isReady ?? this.isReady,
      isBusy: isBusy ?? this.isBusy,
      denyEnabled: denyEnabled ?? this.denyEnabled,
      macs: macs ?? this.macs,
      issim: issim ?? this.issim,
      // message is intentionally not carried over — it's one-shot.
      message: message,
    );
  }
}
