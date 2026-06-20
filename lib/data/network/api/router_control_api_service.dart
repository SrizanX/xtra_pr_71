import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import '../../../domain/result.dart';
import '../../../domain/type.dart';
import '../../demo/demo_mode.dart';
import '../network_client.dart';
import 'api_config.dart';

class RouterControlApiService {
  Future<Result<dynamic>> restart() async {
    if (DemoMode.enabled) return Successful(data: true);
    const url = "${ApiConfig.baseUrl}/jsonp_reset";
    return NetworkClient().get(Uri.parse(url));
  }

  Future<Result<dynamic>> powerOff() async {
    if (DemoMode.enabled) return Successful(data: true);
    const url = "${ApiConfig.baseUrl}/jsonp_power_off?callback=";
    return NetworkClient().get(Uri.parse(url));
  }

  /// Factory-resets the router via `jsonp_recovery_system`. This erases every
  /// setting and reboots, so all connections drop afterwards. Returns true when
  /// the router acknowledges the reset (`mac__address == "success"`).
  Future<Result<bool>> factoryReset() async {
    if (DemoMode.enabled) return Successful(data: true);
    const url = "${ApiConfig.baseUrl}/jsonp_recovery_system";
    final result = await NetworkClient().get(Uri.parse(url));
    switch (result) {
      case Successful<String>():
        try {
          final parser = Xml2Json()..parse(result.data);
          final blog = (jsonDecode(parser.toOpenRally()) as JMap)['blog'];
          return Successful(data: blog['mac__address']?.toString() == 'success');
        } catch (e) {
          return Failed(
            message: 'Unexpected response from router',
            exception: Exception(e.toString()),
          );
        }
      case Failed<String>():
        return Failed(message: result.message, exception: result.exception);
    }
  }
}
