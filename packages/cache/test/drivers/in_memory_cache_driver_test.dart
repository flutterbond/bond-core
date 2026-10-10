import 'package:bond_cache/bond_cache.dart'; // Import your cache package
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryCacheDriver', () {
    late InMemoryCacheDriver cacheDriver;

    setUp(() {
      cacheDriver = InMemoryCacheDriver();
    });

    test('retrieve returns null for non-existing key', () {
      expect(cacheDriver.retrieve('nonexistent_key'), isNull);
    });

    test('store and retrieve data', () async {
      final key = 'test_key';
      final data = {'data': 'test_data', 'expiredAt': null};

      await cacheDriver.store(key, data);
      final retrievedData = cacheDriver.retrieve(key);

      expect(retrievedData, equals(data));
    });

    test('flush clears all data', () async {
      final key = 'test_key';
      final data = {'data': 'test_data', 'expiredAt': null};

      await cacheDriver.store(key, data);
      await cacheDriver.removeAll();

      expect(cacheDriver.retrieve(key), isNull);
    });

    test('forget removes data for a key', () async {
      final key = 'test_key';
      final data = {'data': 'test_data', 'expiredAt': null};

      await cacheDriver.store(key, data);
      await cacheDriver.remove(key);

      expect(cacheDriver.retrieve(key), isNull);
    });

    test('has returns true for existing key', () {
      final key = 'test_key';
      final data = {'data': 'test_data', 'expiredAt': null};

      cacheDriver.store(key, data);

      expect(cacheDriver.has(key), isTrue);
    });

    test('has returns false for non-existing key', () {
      expect(cacheDriver.has('nonexistent_key'), isFalse);
    });
  });
}
