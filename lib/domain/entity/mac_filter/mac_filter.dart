/// Wireless MAC filter state from the `jsonp_macfilterslist` endpoint.
///
/// The router supports a single blocklist: when [denyEnabled] is true the
/// listed [macs] are denied access; everyone else is allowed. The hardware
/// holds at most [maxEntries] addresses.
class MacFilter {
  final bool denyEnabled;
  final List<String> macs;
  final bool issim;

  const MacFilter({
    required this.denyEnabled,
    required this.macs,
    required this.issim,
  });

  /// The router stores exactly 10 MAC slots.
  static const int maxEntries = 10;

  factory MacFilter.fromJson(Map<String, dynamic> json) {
    final raw = (json['allMac'] as String?) ?? '';
    final macs = raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    // macStatus: 0 = off, 2 = deny list (1 = allow list, unused here).
    return MacFilter(
      denyEnabled: json['macStatus']?.toString() == '2',
      macs: macs,
      issim: json['issim']?.toString() == 'true',
    );
  }
}
