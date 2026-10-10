import 'dart:convert';

import 'package:bond_cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  String? getString(String? key) =>
      super.noSuchMethod(Invocation.method(#get, [key]));

  @override
  Future<bool> setString(String key, String value) => super.noSuchMethod(
    Invocation.method(#setString, [key, value]),
    returnValue: Future.value(false),
    returnValueForMissingStub: Future.value(false),
  );

  @override
  bool containsKey(String key) => super.noSuchMethod(
    Invocation.method(#containsKey, [key]),
    returnValue: false,
  );

  @override
  Future<bool> remove(String key) => super.noSuchMethod(
    Invocation.method(#remove, [key]),
    returnValue: Future.value(false),
    returnValueForMissingStub: Future.value(false),
  );

  @override
  Future<bool> clear() => super.noSuchMethod(
    Invocation.method(#remove, []),
    returnValue: Future.value(false),
    returnValueForMissingStub: Future.value(false),
  );
}

void main() {
  group('SharedPreferencesCacheDriver', () {
    late SharedPreferencesCacheDriver cacheDriver;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      cacheDriver = SharedPreferencesCacheDriver(mockSharedPreferences);
    });

    test('retrieve should return null if key does not exist', () {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final result = cacheDriver.retrieve('nonexistent_key');

      expect(result, isNull);
    });

    test('retrieve should return decoded JSON if key exists', () {
      const key = 'existing_key';
      const jsonData = '{"data": "example"}';
      when(mockSharedPreferences.getString(key)).thenReturn(jsonData);

      final result = cacheDriver.retrieve(key);

      expect(result, equals({'data': 'example'}));
    });

    test('store should set string in SharedPreferences', () async {
      const key = 'key';
      const jsonData = {'data': 'example', 'expiredAt': null};

      await cacheDriver.store(key, jsonData);

      verify(mockSharedPreferences.setString(key, jsonEncode(jsonData)))
          .called(1);
    });

    test('has should return true if key exists', () {
      const key = 'existing_key';
      when(mockSharedPreferences.containsKey(key)).thenReturn(true);

      final result = cacheDriver.has(key);

      expect(result, isTrue);
    });

    test('has should return false if key does not exist', () {
      const key = 'nonexistent_key';
      when(mockSharedPreferences.containsKey(key)).thenReturn(false);

      final result = cacheDriver.has(key);

      expect(result, isFalse);
    });

    test('forget should remove key from SharedPreferences', () async {
      const key = 'key';

      await cacheDriver.remove(key);

      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('flush should clear SharedPreferences', () async {
      await cacheDriver.removeAll();

      verify(mockSharedPreferences.clear()).called(1);
    });
  });
}
