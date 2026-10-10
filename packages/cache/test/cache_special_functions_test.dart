import 'package:bond_cache/bond_cache.dart';
import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:test/test.dart';

import 'common/mock_service_provider.dart';
import 'common/not_registered_model.dart';
import 'common/registered_model.dart';

void main() {
  final _mockedServiceProvider = MockServiceProvider();

  setUp(() {
    Cache.cacheDriver = BondCache(driver: InMemoryCacheDriver());
    appProviders.add(_mockedServiceProvider);
  });

  tearDown(() => appProviders.clear());

  group('add', () {
    test('add method stores value if key does not exist and returns true',
        () async {
      final key = 'unique_key';
      final value = 'new_value';

      // Ensure the key does not exist initially
      expect(await Cache.has(key), isFalse);

      // Attempt to add the new value
      final result = await Cache.add<String>(key, value);
      expect(result, isTrue); // Check if the value was successfully added

      // Verify that the value is now stored under the key
      final storedValue = await Cache.get<String>(key);
      expect(storedValue, equals(value));
    });

    test(
        'add method does not store value if key already exists and returns false',
        () async {
      final key = 'existing_key';
      final initialValue = 'initial_value';
      final newValue = 'new_value';

      // Pre-populate the cache with the initial value
      await Cache.put<String>(key, initialValue);
      expect(await Cache.has(key), isTrue);

      // Attempt to add a new value under the same key
      final result = await Cache.add<String>(key, newValue);
      expect(result, isFalse); // Check if the method correctly returns false

      // Verify that the value has not been overwritten
      final storedValue = await Cache.get<String>(key);
      expect(
        storedValue,
        equals(initialValue),
      ); // Should still be the initial value
    });

    test('add method handles optional expiration duration', () async {
      final key = 'expiring_key';
      final value = 'expiring_value';
      final duration = Duration(milliseconds: 100);

      // Add a value with an expiration
      final result = await Cache.add<String>(
        key,
        value,
        expiredAfter: duration,
      );
      expect(result, isTrue);

      // Initially check the value is there
      var storedValue = await Cache.get<String?>(key);
      expect(storedValue, equals(value));

      // Wait for more than the expiration duration
      await Future.delayed(Duration(milliseconds: 200));

      // Check that the value has expired
      storedValue = await Cache.get<String?>(key);
      expect(storedValue, isNull);
    });
  });

  group('forever', () {
    test('forever method stores value indefinitely', () async {
      final key = 'forever_key';
      final value = 'forever_value';

      // Store the value using the forever method
      final result = await Cache.forever<String>(key, value);
      expect(
        result,
        isTrue,
      ); // Ensure the method returns true indicating success

      // Retrieve the stored value to confirm it's correctly stored
      final storedValue = await Cache.get<String>(key);
      expect(
        storedValue,
        equals(value),
      ); // The stored value should match the input value

      // Optionally, you could add a sleep or delay (simulate passage of time) and re-check
      // This step is conceptual since there's no expiration, but you might include it to demonstrate the "forever" concept
      await Future.delayed(
        Duration(milliseconds: 10),
      ); // Example delay; adjust as necessary

      // Re-check the value to confirm it's still present after some time
      final recheckedValue = await Cache.get<String>(key);
      expect(recheckedValue, equals(value)); // Value should still be there
    });

    test('forever method overwrites existing value', () async {
      final key = 'overwrite_key';
      final initialValue = 'initial_value';
      final newValue = 'new_value';

      // Initially store a value
      await Cache.forever<String>(key, initialValue);

      // Store a new value using the same key
      final result = await Cache.forever<String>(key, newValue);
      expect(result, isTrue); // Ensure the method returns true

      // Check that the new value replaced the old value
      final currentValue = await Cache.get<String>(key);
      expect(currentValue, equals(newValue)); // Should be the new value
    });
  });

  group('forget', () {
    test('forget method removes existing key and returns true', () async {
      final key = 'removable_key';
      final value = 'removable_value';

      // Store a value initially to ensure there is something to remove
      await Cache.forever<String>(key, value);

      // Check if the value is initially present
      var exists = await Cache.has(key);
      expect(exists, isTrue);

      // Attempt to remove the key
      final result = await Cache.forget(key);
      expect(result, isTrue); // Check if the removal was reported as successful

      // Verify the key is no longer in the cache
      exists = await Cache.has(key);
      expect(exists, isFalse);
    });

    test('forget method returns false if key does not exist', () async {
      final key = 'nonexistent_key';

      // Ensure the key does not exist
      var exists = await Cache.has(key);
      expect(exists, isFalse);

      // Attempt to remove a non-existing key
      final result = await Cache.forget(key);
      expect(
        result,
        isFalse,
      ); // Removal should report as unsuccessful since the key does not exist
    });
  });

  group('increment and decrement', () {
    test('increment method creates new entry if key does not exist', () async {
      final key = 'increment_key';

      // Ensure the key does not exist
      var exists = await Cache.has(key);
      expect(exists, isFalse);

      // Increment the non-existing key
      final result = await Cache.increment(key, 5);
      expect(result, isTrue);

      // Check if the value is set to the increment amount
      final newValue = await Cache.get<int>(key);
      expect(newValue, equals(5));
    });

    test('increment method increases existing value', () async {
      final key = 'increment_existing_key';
      await Cache.put<int>(key, 10);

      // Increment the existing value
      final result = await Cache.increment(key, 3);
      expect(result, isTrue);

      // Verify the value is incremented correctly
      final newValue = await Cache.get<int>(key);
      expect(newValue, equals(13));
    });

    test('decrement method creates new entry if key does not exist', () async {
      final key = 'decrement_key';

      // Ensure the key does not exist
      var exists = await Cache.has(key);
      expect(exists, isFalse);

      // Decrement the non-existing key
      final result = await Cache.decrement(key, 2);
      expect(result, isTrue);

      // Check if the value is set to negative of the decrement amount
      final newValue = await Cache.get<int>(key);
      expect(newValue, equals(-2));
    });

    test('decrement method decreases existing value', () async {
      final key = 'decrement_existing_key';
      await Cache.put<int>(key, 10);

      // Decrement the existing value
      final result = await Cache.decrement(key, 3);
      expect(result, isTrue);

      // Verify the value is decremented correctly
      final newValue = await Cache.get<int>(key);
      expect(newValue, equals(7));
    });
  });

  group('pull', () {
    test('pull method retrieves and removes the value if key exists', () async {
      final key = 'pull_key';
      final value = 'pull_value';

      // Initially store a value
      await Cache.put<String>(key, value);

      // Pull the value
      final pulledValue = await Cache.pull<String>(key);
      expect(
          pulledValue, equals(value)); // Verify the retrieved value is correct

      // Verify the key has been removed from the cache
      final exists = await Cache.has(key);
      expect(exists, isFalse);
    });

    test('pull method returns null if key does not exist', () async {
      final key = 'nonexistent_key';

      // Pull using a non-existing key
      final pulledValue = await Cache.pull<String?>(key);
      expect(
        pulledValue,
        isNull,
      ); // Should return null as the default value is not provided and key does not exist
    });

    test('pull method uses fromJsonFactory to deserialize and remove object',
        () async {
      final key = 'pull_object_key';
      final value = NotRegisteredModel.data('pull_object_value');

      // Store the object in the cache
      await Cache.put<NotRegisteredModel>(key, value);

      // Pull the object using the fromJsonFactory
      final pulledValue = await Cache.pull<NotRegisteredModel>(
        key,
        fromJsonFactory: NotRegisteredModel.fromJson,
      );
      expect(
        pulledValue,
        equals(value),
      ); // Should return the object stored in the cache

      // Verify the key has been removed from the cache
      final exists = await Cache.has(key);
      expect(exists, isFalse);
    });

    test('pull method uses providers to deserialize and remove object',
        () async {
      final key = 'pull_object_key';
      final value = RegisteredModel.data('pull_object_value');

      // Store the object in the cache
      await Cache.put<RegisteredModel>(key, value);

      // Pull the object using the provider
      final pulledValue = await Cache.pull<RegisteredModel>(key);
      expect(
        pulledValue,
        equals(value),
      ); // Should return the object stored in the cache

      // Verify the key has been removed from the cache
      final exists = Cache.has(key);
      expect(exists, isFalse);
    });

    test(
        'pull method returns default value if key does not exist and default is provided',
        () async {
      final key = 'nonexistent_key';
      final defaultValue = 'default_value';

      // Pull using a non-existing key with a default value provided
      final pulledValue = await Cache.pull<String>(
        key,
        defaultValue: defaultValue,
      );
      expect(
        pulledValue,
        equals(defaultValue),
      ); // Should return the default value specified
    });
  });
}
