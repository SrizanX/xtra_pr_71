import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import '../../../domain/entity/apn/apn_settings.dart';
import '../../../domain/type.dart';
import 'base/mapper.dart';

/// Maps the `jsonp_pin_apn_setting` response (a `blog` object of `mApn*` fields)
/// to [ApnSettings].
class ApnSettingsApiMapper extends Mapper<dynamic, ApnSettings> {
  @override
  ApnSettings map(input) {
    final xmlParser = Xml2Json();
    xmlParser.parse(input);
    final decoded = jsonDecode(xmlParser.toOpenRally()) as JMap;
    return ApnSettings.fromJson(Map<String, dynamic>.from(decoded['blog']));
  }
}
