import '../../constants.dart';

/// Traffic statistics from the `jsonp_statistics` endpoint.
///
/// The router's field names are misleading: in the source payload `m__ip` is
/// the **download** total and `mac__address` is the **upload** total. They are
/// translated to clear names here. Totals are human-readable strings
/// (e.g. "10.213MB") and [speed] is the current throughput (e.g. "0.0K/s").
class UsageStatistics {
  final String download;
  final String upload;
  final String speed;
  final String total;

  const UsageStatistics({
    required this.download,
    required this.upload,
    required this.speed,
    required this.total,
  });

  factory UsageStatistics.fromJson(Map<String, dynamic> json) =>
      UsageStatistics(
        download: json['m__ip'] ?? cUnknownStr, // m__ip is download
        upload: json['mac__address'] ?? cUnknownStr, // mac__address is upload
        speed: json['speed'] ?? cUnknownStr,
        total: json['sumstatis'] ?? cUnknownStr,
      );
}
