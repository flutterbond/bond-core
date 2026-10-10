import 'dart:convert';

import 'package:bond_cache/bond_cache.dart';
import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:mockito/mockito.dart';

class MockCacheDriver extends CacheDriver with Mock {
  @override
  bool has(String? key) =>
      super.noSuchMethod(Invocation.method(#has, [key]), returnValue: true);

  @override
  Json? retrieve(String? key) =>
      super.noSuchMethod(Invocation.method(#retrieve, [key]));

  @override
  Future<bool> store(String? key, Json? data) => super.noSuchMethod(
    Invocation.method(#store, [key, data]),
    returnValue: Future.value(false),
  );

  @override
  Future<bool> remove(String? key) => super.noSuchMethod(
    Invocation.method(#remove, [key]),
    returnValue: Future.value(false),
  );

  @override
  Future<bool> removeAll() => super.noSuchMethod(
    Invocation.method(#removeAll, []),
    returnValue: Future.value(false),
  );

  void whenHasThenReturn({String? key, required bool returnValue}) {
    when(has(key ?? any)).thenReturn(returnValue);
  }

  void whenRetrieveThenReturn({
    String? key,
    required Map<String, dynamic>? cachedData,
  }) {
    when(retrieve(key ?? any)).thenReturn(cachedData);
  }

  void whenRemoveThenAnswer({String? key, bool answer = true}) {
    when(remove(key ?? any)).thenAnswer((_) async => answer);
  }

  void whenStoreThenAnswer<T>({String? key, T? value, bool answer = true}) {
    final data = {'data': jsonDecode(jsonEncode(value)), 'expiredAt': null};
    when(store(key ?? any, value != null ? data : any))
        .thenAnswer((_) async => answer);
  }
}
