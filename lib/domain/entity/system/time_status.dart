/// Router time status from `jsonp_usbstatus1` (wrapper key `blogss`).
///
/// We only use the time-related fields: whether automatic time zone is on, the
/// current clock, and the selected time-zone index ([timezone] matches a
/// `kTimezones` value).
class TimeStatus {
  final bool isAutoTimezone;
  final String time;
  final String timezone;

  const TimeStatus({
    required this.isAutoTimezone,
    required this.time,
    required this.timezone,
  });

  factory TimeStatus.fromJson(Map<String, dynamic> json) => TimeStatus(
        isAutoTimezone: json['isAutoTimezone']?.toString() == 'true',
        time: json['time']?.toString() ?? '',
        timezone: json['timezone']?.toString() ?? '',
      );
}
