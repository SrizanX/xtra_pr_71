import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/mapper/base/mapper.dart';

import '../../../domain/entity/statistics/usage_statistics.dart';
import '../../../domain/type.dart';

/// Maps the `jsonp_statistics` response to [UsageStatistics].
///
/// The OpenRally JSON looks like:
/// ```json
/// {"com.linsx.webserver.utils.StatisticsInfo":
///   {"m__ip": "10.213MB", "mac__address": "36.630MB",
///    "speed": "0.0K/s", "sumstatis": "46.843MB"}}
/// ```
class StatisticsApiMapper extends Mapper<dynamic, UsageStatistics> {
  @override
  UsageStatistics map(input) {
    final xmlParser = Xml2Json();
    xmlParser.parse(input);
    final decoded = jsonDecode(xmlParser.toOpenRally()) as JMap;
    final info = decoded['com.linsx.webserver.utils.StatisticsInfo'] as Map;
    return UsageStatistics.fromJson(Map<String, dynamic>.from(info));
  }
}
