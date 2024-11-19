import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/mapper/base/mapper.dart';

import '../../../domain/entity/wireless/wireless_info.dart';

class WirelessSettingApiMapper extends Mapper<dynamic, WirelessInfo> {
  @override
  WirelessInfo map(input) {
    var xmlParser = Xml2Json();
    xmlParser.parse(input);
    final decodedResponse = jsonDecode(
        xmlParser.toOpenRally())['com.linsx.webserver.utils.WifiInfo'];
    return WirelessInfo.fromJson(decodedResponse);
  }
}
