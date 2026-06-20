import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/mapper/base/mapper.dart';

import '../../../domain/entity/device/connected_device.dart';
import '../../../domain/type.dart';

/// Maps the `jsonp_device_management_all` response to connected devices.
///
/// The OpenRally JSON looks like:
/// ```json
/// {"com.linsx.webserver.ConnectInfo":
///   {"Items": {"Item": [{"m__ip": "...", "mac__address": "..."}]}}}
/// ```
/// `Item` is a list for multiple clients, a single object for one, and absent
/// when none are connected — all three are handled here.
class ConnectedDevicesApiMapper
    extends Mapper<dynamic, List<ConnectedDevice>> {
  @override
  List<ConnectedDevice> map(input) {
    final xmlParser = Xml2Json();
    xmlParser.parse(input);
    final decoded = jsonDecode(xmlParser.toOpenRally()) as JMap;

    final connectInfo = decoded['com.linsx.webserver.ConnectInfo'];
    if (connectInfo is! Map) return const [];

    final items = connectInfo['Items'];
    if (items is! Map) return const [];

    final item = items['Item'];
    final rawList = switch (item) {
      List() => item,
      Map() => [item],
      _ => const [],
    };

    return rawList
        .whereType<Map>()
        .map((e) => ConnectedDevice.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
