import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'cache/helpers/mock_cache_driver.dart';

void main() {
  setUp(() {
    Cache.cacheDriver = BondCache(driver: InMemoryCacheDriver());
  });

  group('has', () {
    test('has method returns true if key exists in cache', () {
      final key = 'test_key';
      final value = 'cached_value';

      Cache.put<String>(key, value);

      final result = Cache.has(key);
      expect(result, isTrue);
    });

    test('has method returns false if key does not exist in cache', () {
      final key = 'test_key';

      final result = Cache.has(key);
      expect(result, isFalse);
    });
  });
  group('store', () {
    setUpAll(() {
      sl.registerFactory<BondCache>(
        () => BondCache(driver: MockCacheDriver()),
        instanceName: 'myStore',
      );
    });
    test('returns correct CacheDriver instance for a store name', () {
      var cacheDriver = Cache.store('myStore').driver;
      expect(cacheDriver, isA<MockCacheDriver>());
    });

    test('returns separate instances for different store names', () {
      // Setup a different instance for a new store name
      sl.registerFactory<BondCache>(
        () => BondCache(driver: MockCacheDriver()),
        instanceName: 'newStore',
      );

      var cacheDriver1 = Cache.store('myStore').driver;
      var cacheDriver2 = Cache.store('newStore').driver;

      expect(cacheDriver1, isNot(equals(cacheDriver2)));
      expect(cacheDriver1, isA<MockCacheDriver>());
      expect(cacheDriver2, isA<MockCacheDriver>());
    });
  });

  test('clear method removes all entries from the cache', () async {
    // Populate the cache with some entries
    await Cache.put<String>('key1', 'value1');
    await Cache.put<String>('key2', 'value2');
    await Cache.put<int>('key3', 3);

    // Verify cache is populated
    expect(Cache.has('key1'), isTrue);
    expect(Cache.has('key2'), isTrue);
    expect(Cache.has('key3'), isTrue);

    // Clear the cache
    await Cache.clear();

    // Verify the cache is empty
    expect(Cache.has('key1'), isFalse);
    expect(Cache.has('key2'), isFalse);
    expect(Cache.has('key3'), isFalse);
  });
}
