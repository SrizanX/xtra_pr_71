import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xtra_pr_71/domain/result.dart';

class NetworkClient {
  final int _timeoutDuration = 5;

  const NetworkClient._();

  static const NetworkClient instance = NetworkClient._();

  factory NetworkClient() => instance;

  Future<Result> get(Uri uri) {
    return _handleHttpResponse(
      () => http.get(uri).timeout(Duration(seconds: _timeoutDuration)),
    );
  }

  Future<Result<String>> _handleHttpResponse(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      _logResponse(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Successful(data: response.body);
      } else {
        return Failed(message: _getHttpStatusMessage(response.statusCode));
      }
    } on SocketException catch (e) {
      return Failed(message: "Connection failed", exception: e);
    } on TimeoutException catch (e) {
      return Failed(message: "Connection timeout", exception: e);
    } on Exception catch (e) {
      return Failed(message: "Something went wrong", exception: e);
    }
  }

  String _getHttpStatusMessage(int statusCode) {
    switch (statusCode) {
      case 401:
        return "401: May be you are connected to a different router";

      case 403:
        return "403: May be you are connected to a different router";

      default:
        return "Unknown error occurred!";
    }
  }

  void _logResponse(http.Response response) {
    if (kDebugMode) {
      debugPrint('Request Body: ${response.request}');
      if (response.request is http.Request) {
        final bodyBytes = (response.request as http.Request).bodyBytes;
        final bodyString = utf8.decode(bodyBytes);
        debugPrint('Body: $bodyString');
      }
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
    }
  }
}
