import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import '../../../domain/entity/mac_filter/mac_filter.dart';
import '../../../domain/type.dart';
import 'base/mapper.dart';

/// Maps the `jsonp_macfilterslist` response, e.g.:
/// ```json
/// {"blog": {"allMac": "40:4d:8e:6d:80:7d,40:4d:8e:6d:80:7f",
///           "issim": "false", "macStatus": "2"}}
/// ```
class MacFilterApiMapper extends Mapper<dynamic, MacFilter> {
  @override
  MacFilter map(input) {
    final xmlParser = Xml2Json();
    xmlParser.parse(input);
    final decoded = jsonDecode(xmlParser.toOpenRally()) as JMap;
    return MacFilter.fromJson(Map<String, dynamic>.from(decoded['blog']));
  }
}
