import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xtra_pr_71/domain/result.dart';

class NetworkClient {
  final int _timeoutDuration = 5;

  /// Hard cap on a response body. The router's JSONP/XML replies are a few KB;
  /// anything far bigger means we're talking to something that isn't the PR71
  /// (e.g. a different router's full HTML admin page). Parsing such a payload
  /// runs synchronously on the UI isolate and can freeze the app (ANR), so we
  /// reject it up front instead of handing it to a mapper.
  static const int _maxResponseBytes = 1024 * 1024; // 1 MB

  const NetworkClient._();

  static const NetworkClient instance = NetworkClient._();

  factory NetworkClient() => instance;

  /// Test-only override for the underlying HTTP client (e.g. an `http`
  /// `MockClient`). Production uses a one-shot [http.get] that closes itself.
  @visibleForTesting
  static http.Client? testClient;

  Future<Result<String>> get(Uri uri) {
    return _handleHttpResponse(
      () => (testClient?.get(uri) ?? http.get(uri))
          .timeout(Duration(seconds: _timeoutDuration)),
    );
  }

  Future<Result<String>> _handleHttpResponse(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      _logResponse(response);
      final code = response.statusCode;
      if (code >= 200 && code < 300) {
        // An oversized body means we're not talking to a PR71 (e.g. a different
        // router's HTML admin page). Reject it before it reaches the XML/JSON
        // parsers on the UI isolate, which would otherwise risk an ANR.
        if (response.bodyBytes.length > _maxResponseBytes) {
          return _fail(NetworkFailure.wrongDevice);
        }
        return Successful(data: response.body);
      }
      // 401/403: something is at this address but it isn't the PR71 (commonly a
      // different router). Other codes are unexpected server errors.
      if (code == 401 || code == 403) return _fail(NetworkFailure.wrongDevice);
      return _fail(
        NetworkFailure.unknown,
        message: "The router returned an error (HTTP $code).",
      );
    } on SocketException catch (e) {
      // No route / connection refused / network unreachable → not connected to
      // the router (Wi-Fi off, switched network, or router down).
      return _fail(NetworkFailure.unreachable, exception: e);
    } on TimeoutException catch (e) {
      return _fail(NetworkFailure.unreachable, exception: e);
    } on http.ClientException catch (e) {
      return _fail(NetworkFailure.unreachable, exception: e);
    } on Exception catch (e) {
      return _fail(NetworkFailure.unknown, exception: e);
    }
  }

  Failed<String> _fail(
    NetworkFailure kind, {
    String? message,
    Exception? exception,
  }) =>
      Failed(message: message ?? kind.message, kind: kind, exception: exception);

  void _logResponse(http.Response response) {
    if (!kDebugMode) return;
    debugPrint('Request: ${response.request}');
    debugPrint('Status Code: ${response.statusCode}');
    // Only log a short preview — debugPrint throttles output, so dumping a
    // large foreign-router HTML page here is itself slow enough to jank the UI.
    final bytes = response.bodyBytes;
    final preview = utf8.decode(
      bytes.length > 1000 ? bytes.sublist(0, 1000) : bytes,
      allowMalformed: true,
    );
    final suffix = bytes.length > 1000 ? '… (${bytes.length} bytes)' : '';
    debugPrint('Response Body: $preview$suffix');
  }
}
