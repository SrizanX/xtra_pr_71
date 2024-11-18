import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/mapper/base/mapper.dart';
import 'package:xtra_pr_71/domain/type.dart';

import '../../../domain/entity/device_info.dart';

class DashboardApiMapper extends Mapper<dynamic, DeviceInfo> {
  @override
  DeviceInfo map(input) {
    var xmlParser = Xml2Json();
    xmlParser.parse(input);
    var decodedJson =
        jsonDecode(xmlParser.toOpenRally()) as JMap;
    return DeviceInfo.fromJson(decodedJson['deviceinfo']);
  }
}
