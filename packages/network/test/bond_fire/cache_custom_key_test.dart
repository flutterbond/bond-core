import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_network/bond_network.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    final dio = Dio()
      ..httpClientAdapter = _JsonAdapter({
        'data': {'token': 'abc123'},
      });
    sl.registerSingleton<Dio>(dio);
    Cache.cacheDriver = BondCache(driver: _MicrotaskCacheDriver());
  });

  tearDown(() => sl.reset());

  test('custom cache key is readable as soon as execute() returns', () async {
    await BondFire()
        .post<Map<String, dynamic>>('/login')
        .cacheCustomKey<String>('token', path: 'data.token')
        .execute();

    expect(Cache.get<String>('token'), 'abc123');
  });

  test('BondFire() is not a singleton', () {
    expect(identical(BondFire(), BondFire()), isFalse);
  });
}

/// Answers every request with [body] as JSON.
class _JsonAdapter implements HttpClientAdapter {
  _JsonAdapter(this.body);

  final Map<String, dynamic> body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode(body),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

/// Acknowledges a write at once but applies it a few microtasks later, like
/// drivers backed by platform channels (e.g. a mocked FlutterSecureStorage).
class _MicrotaskCacheDriver extends CacheDriver {
  final _data = <String, Map<String, dynamic>>{};

  @override
  Future<bool> store(String key, Map<String, dynamic> data) {
    _afterMicrotasks(10, () => _data[key] = data);
    return Future.value(true);
  }

  @override
  bool has(String key) => _data.containsKey(key);

  @override
  Map<String, dynamic>? retrieve(String key) => _data[key];

  @override
  Future<bool> remove(String key) async => _data.remove(key) != null;

  @override
  Future<bool> removeAll() async {
    _data.clear();
    return true;
  }
}

void _afterMicrotasks(int hops, void Function() action) => scheduleMicrotask(
  hops == 0 ? action : () => _afterMicrotasks(hops - 1, action),
);
