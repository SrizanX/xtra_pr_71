// Verifies the network layer classifies each "wrong network" edge case so the
// UI can guide the user: Wi-Fi off / router off / switched away (unreachable),
// a different router at the same address (wrongDevice), and a healthy reply.

import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:xtra_pr_71/data/network/network_client.dart';
import 'package:xtra_pr_71/domain/result.dart';

void main() {
  final uri = Uri.parse('http://192.168.0.1/jsonp_dashboard');

  tearDown(() => NetworkClient.testClient = null);

  Future<Result<String>> getWith(MockClient client) {
    NetworkClient.testClient = client;
    return NetworkClient().get(uri);
  }

  NetworkFailure kindOf(Result<String> r) => (r as Failed<String>).kind;

  test('healthy small 200 → Successful', () async {
    final r = await getWith(MockClient((_) async => http.Response('{"a":1}', 200)));
    expect(r, isA<Successful<String>>());
    expect((r as Successful<String>).data, '{"a":1}');
  });

  test('socket error (Wi-Fi off / router off) → unreachable', () async {
    final r = await getWith(
      MockClient((_) async => throw const SocketException('no route')),
    );
    expect(kindOf(r), NetworkFailure.unreachable);
  });

  test('timeout (router not responding) → unreachable', () async {
    final r = await getWith(
      MockClient((_) async => throw TimeoutException('slow')),
    );
    expect(kindOf(r), NetworkFailure.unreachable);
  });

  test('403 from a different router → wrongDevice', () async {
    final r = await getWith(
      MockClient((_) async => http.Response('<html>403</html>', 403)),
    );
    expect(kindOf(r), NetworkFailure.wrongDevice);
  });

  test('oversized 200 (foreign admin page) → wrongDevice', () async {
    final big = 'a' * (1024 * 1024 + 1);
    final r = await getWith(MockClient((_) async => http.Response(big, 200)));
    expect(kindOf(r), NetworkFailure.wrongDevice);
  });

  test('500 → unknown', () async {
    final r = await getWith(MockClient((_) async => http.Response('err', 500)));
    expect(kindOf(r), NetworkFailure.unknown);
  });
}
