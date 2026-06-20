import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/result.dart';

import '../../../domain/entity/system/time_status.dart';
import '../../../domain/type.dart';
import '../../demo/demo_data.dart';
import '../../demo/demo_mode.dart';
import '../mapper/base/result_mapper.dart';
import '../mapper/state_response_mapper.dart';
import '../model/state_response.dart';
import 'api_config.dart';

/// Router system settings: admin password and time zone.
class SystemSettingsApiService {
  /// Changes the admin password via `modifyUser`. The router validates that
  /// both passwords are 4–20 alphanumeric characters.
  Future<Result<StateResponse>> changeAdminPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final param = {"olapsd": oldPassword, "newpsd": newPassword};
    const url = "${ApiConfig.baseUrl}/modifyUser";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"modifyparam": jsonEncode(param)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }

  /// Sets the time zone via `selecttimezone`. [value] is the timezone index
  /// from `kTimezones`.
  Future<Result<StateResponse>> setTimezone(String value) async {
    if (DemoMode.enabled) return Successful(data: DemoData.ok);
    final param = {"mySelect": value};
    const url = "${ApiConfig.baseUrl}/selecttimezone";
    final result = await NetworkClient().get(
      Uri.parse(url).replace(queryParameters: {"timezone": jsonEncode(param)}),
    );
    return ResultMapper().map(result: result, mapper: StateApiMapper());
  }

  /// Reads the current time status (auto time zone, clock, time-zone index)
  /// from `jsonp_usbstatus1`.
  Future<Result<TimeStatus>> fetchTimeStatus() async {
    if (DemoMode.enabled) return Successful(data: DemoData.timeStatus);
    const url = "${ApiConfig.baseUrl}/jsonp_usbstatus1?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    switch (result) {
      case Successful<String>():
        try {
          final parser = Xml2Json()..parse(result.data);
          final blog = (jsonDecode(parser.toOpenRally()) as JMap)['blogss'];
          return Successful(
            data: TimeStatus.fromJson(Map<String, dynamic>.from(blog)),
          );
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

  /// Flips automatic time zone on/off and returns the resulting state
  /// (`isAutoTimeZon`). The endpoint toggles on each call.
  Future<Result<bool>> toggleAutoTimeZone() async {
    if (DemoMode.enabled) {
      return Successful(data: !DemoData.timeStatus.isAutoTimezone);
    }
    const url = "${ApiConfig.baseUrl}/jsonp_auto_time_zone?callback=";
    final result = await NetworkClient().get(Uri.parse(url));
    switch (result) {
      case Successful<String>():
        try {
          final parser = Xml2Json()..parse(result.data);
          final blog = (jsonDecode(parser.toOpenRally()) as JMap)['blog'];
          return Successful(data: blog['isAutoTimeZon']?.toString() == 'true');
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
