import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';

import 'cache/cache_driver.dart';
import 'helpers/common_cache_helper.dart';

/// A static class providing methods to interact with the caching system.
class Cache {
  /// The cache driver used for caching operations.
  static BondCache cacheDriver = BondCache(driver: sl<CacheDriver>());

  /// Retrieves a value from the cache with the specified [key].
  ///
  /// If the [key] is present in the cache, returns the cached value. If not,
  /// returns the provided [defaultValue].
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [defaultValue] The value to return if the [key] is not found in the cache.
  /// - Parameter [fromJsonFactory] optional factory function that takes a
  ///   `Map<String, dynamic>` (representing the JSON data) and returns an instance of type T.
  /// - Returns: The cached value if [key] is found, otherwise [defaultValue].
  /// - Throws: An error if there is an issue during the cache retrieval process.
  /// Usage:
  /// ```dart
  /// var user = Cache.get<User>("user", defaultValue: User());
  /// ``
  static T get<T>(
    String key, {
    dynamic defaultValue,
    Factory<T>? fromJsonFactory,
  }) => cacheDriver.get<T>(
    key,
    defaultValue: defaultValue,
    fromJsonFactory: fromJsonFactory,
  );

  /// Retrieves a list of cached data associated with the specified [key].
  /// - Parameter [key] The key associated with the cached data.
  /// - Parameter [defaultValue] The default value or function returning the value.
  /// - Parameter [fromJsonFactory] The factory function for deserialization of the list elements.
  /// - Returns: The list of cached data of type [T] or the default value if not found or invalid.
  /// - Throws: [ArgumentError] if the value type is not supported.
  /// Usage:
  /// ```dart
  /// var settings = Cache.getAll<Setting>("settings");
  /// ```
  static List<T> getAll<T>(
    String key, {
    dynamic defaultValue,
    Factory<T>? fromJsonFactory,
  }) => cacheDriver.getAll<T>(
    key,
    defaultValue: defaultValue,
    fromJsonFactory: fromJsonFactory,
  );

  /// Checks if a value with the specified [key] exists in the cache.
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Returns: `true` if the [key] is present in the cache, otherwise `false`.
  /// Usage:
  /// ```dart
  /// var exists = Cache.has("user");
  /// ```
  static bool has(String key) => cacheDriver.has(key);

  /// Stores a value in the cache with the specified [key].
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [value] The value to be stored in the cache.
  /// - Parameter [expiredAfter] An optional duration after which the cached value should expire.
  /// - Returns: `true` if the value was successfully stored in the cache, otherwise `false`.
  /// - Throws: An error if there is an issue during the cache storage process.
  /// Usage:
  /// ```dart
  /// var success = Cache.put<User>("user", myUser, expiredAfter: Duration(days: 1));
  /// ```
  static Future<bool> put<T>(String key, T value, {Duration? expiredAfter}) =>
      cacheDriver.put<T>(key, value, expiredAfter);

  /// Stores a list of values in the cache with the specified [key].
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [value] The value to be stored in the cache.
  /// - Parameter [expiredAfter] An optional duration after which the cached value should expire.
  /// - Returns: `true` if the value was successfully stored in the cache, otherwise `false`.
  /// - Throws: An error if there is an issue during the cache storage process.
  /// Usage:
  /// ```dart
  /// var success = Cache.putAll<User>("users", myUsers, expiredAfter: Duration(days: 1));
  /// ```
  static Future<bool> putAll<T>(
    String key,
    List<T> value, {
    Duration? expiredAfter,
  }) => cacheDriver.putAll<T>(key, value, expiredAfter);

  /// Stores a value in the cache with the specified [key] if the key does not exist.
  ///
  /// If the [key] is already present in the cache, this method does nothing and returns `false`.
  /// If the [key] is not present, the [value] is stored, and it returns `true`.
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [value] The value to be stored in the cache.
  /// - Parameter [expiredAfter] An optional duration after which the cached value should expire.
  /// - Returns: `true` if the value was successfully stored in the cache, otherwise `false`.
  /// - Throws: An error if there is an issue during the cache storage process.
  /// Usage:
  /// ```dart
  /// var success = Cache.add<User>("user", myUser, expiredAfter: Duration(days: 1));
  /// ```
  static Future<bool> add<T>(
    String key,
    T value, {
    Duration? expiredAfter,
  }) async {
    final exist = has(key);
    if (!exist) return put<T>(key, value, expiredAfter: expiredAfter);
    return false;
  }

  /// Stores a value in the cache with the specified [key], without an expiration time.
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [value] The value to be stored in the cache.
  /// - Returns: `true` if the value was successfully stored in the cache.
  /// - Throws: An error if there is an issue during the cache storage process.
  /// Usage:
  /// ```dart
  /// var success = Cache.forever<User>("user", myUser);
  /// ```
  static Future<bool> forever<T>(String key, T value) => put<T>(key, value);

  /// Removes a value with the specified [key] from the cache.
  ///
  /// - Parameter [key] The unique identifier for the cached value to be removed.
  /// - Returns: `true` if the value was successfully removed from the cache, otherwise `false`.
  /// Usage:
  /// ```dart
  /// var success = Cache.forget("user");
  /// ```
  static Future<bool> forget(String key) => cacheDriver.forget(key);

  /// Increments the value stored with the specified [key] in the cache.
  ///
  /// If the [key] is not present in the cache, a new entry with the provided [amount] is created.
  /// If the [key] is present and its value is a numeric type, the value is incremented by [amount].
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [amount] The amount by which to increment the value.
  /// - Returns: `true` if the value was successfully incremented in the cache, otherwise `false`.
  /// - Throws: An error if there is an issue during the cache increment process.
  /// Usage:
  /// ```dart
  /// var success = Cache.increment("counter", 2);
  /// ```
  static Future<bool> increment(String key, [int amount = 1]) async {
    final value = get<int?>(key) ?? 0;
    return put<int>(key, value + amount);
  }

  /// Decrements the value stored with the specified [key] in the cache.
  ///
  /// If the [key] is not present in the cache, a new entry with the provided [amount] is created.
  /// If the [key] is present and its value is a numeric type, the value is decremented by [amount].
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [amount] The amount by which to decrement the value.
  /// - Returns: `true` if the value was successfully decremented in the cache, otherwise `false`.
  /// - Throws: An error if there is an issue during the cache decrement process.
  /// Usage:
  /// ```dart
  /// var success = Cache.decrement("counter", 2);
  /// ```
  static Future<bool> decrement(String key, [int amount = 1]) async {
    final value = get<int?>(key) ?? 0;
    return put<int>(key, value - amount);
  }

  /// Retrieves a value from the cache with the specified [key], then removes the entry.
  ///
  /// If the [key] is present in the cache, returns the cached value and removes the entry.
  /// If the [key] is not found, returns the provided [defaultValue].
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [defaultValue] The value to return if the [key] is not found in the cache.
  /// - Parameter [fromJsonFactory] optional factory function that takes a `Map<String, dynamic>` (representing the JSON data) and returns an instance of type T.
  /// - Returns: The cached value if [key] is found, otherwise [defaultValue].
  /// - Throws: An error if there is an issue during the cache retrieval or removal process.
  /// Usage:
  /// ```dart
  /// var user = Cache.pull<User>("user");
  /// ```
  static Future<T> pull<T>(
    String key, {
    dynamic defaultValue,
    Factory<T>? fromJsonFactory,
  }) async {
    final value = get<T>(
      key,
      defaultValue: defaultValue,
      fromJsonFactory: fromJsonFactory,
    );
    await forget(key);
    return value;
  }

  /// Stores a value in the cache with the specified [key] and an expiration time.
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [expiredAfter] The duration after which the cached value should expire.
  /// - Parameter [function] A function that returns the value to be cached.
  /// - Throws: An error if there is an issue during the cache storage process or while executing the function.
  /// Usage:
  /// ```dart
  /// await Cache.remember<User>(
  ///   "user",
  ///   Duration(days: 1),
  ///   () async => await fetchUserFromApi(),
  /// );
  /// ```
  static Future<void> remember<T>(
    String key,
    Duration expiredAfter,
    Future<T> Function() function,
  ) async {
    final result = await function();
    await put<T>(key, result, expiredAfter: expiredAfter);
  }

  /// Stores a value in the cache with the specified [key] without an expiration time.
  ///
  /// - Parameter [key] The unique identifier for the cached value.
  /// - Parameter [function] A function that returns the value to be cached.
  /// - Throws: An error if there is an issue during the cache storage process or while executing the function.
  /// Usage:
  /// ```dart
  /// await Cache.rememberForever<User>(
  ///   "user",
  ///   () async => await fetchUserFromApi(),
  /// );
  /// ```
  static Future<void> rememberForever<T>(
    String key,
    Future<T> Function() function,
  ) async {
    final result = await function();
    await put<T>(key, result);
  }

  /// Adds an observer for a specific cache key.
  /// - Parameters:
  ///  -[key] The cache key to watch.
  ///  -[observer] The observer that will be notified when the key is updated or deleted.
  ///  Usage:
  ///  ```dart
  ///  Cache.watch<int>(key, observer);
  ///  ```
  static void watch<T>(String key, CacheObserver<T> observer) {
    cacheDriver.watch<T>(key, observer);
  }

  /// Removes an observer for a specific cache key.
  /// - Parameters:
  /// -[key] The cache key the observer is watching.
  /// -[observer] The observer to remove.
  /// Usage:
  /// ```dart
  /// Cache.unwatch<int>(key, observer);
  /// ```
  static void unwatch<T>(String key, [CacheObserver<T>? observer]) {
    cacheDriver.unwatch<T>(key, observer);
  }

  /// Returns a [Stream] that emits values when a specific cache key is updated.
  /// - Parameters:
  /// -[key] The cache key to watch.
  ///  - Returns: A [Stream] that emits values of type [T] when the key is updated.
  ///  - Throws: [ArgumentError] if [Key] is already being observed by a different type.
  ///  Usage:
  ///  ```dart
  ///  var stream = Cache.stream<int>(key);
  ///  ```
  static Stream<T> stream<T>(String key) {
    return cacheDriver.stream<T>(key);
  }

  /// Creates and returns a new [CacheDriver] instance with the specified [storeName].
  ///
  /// The [storeName] is used to uniquely identify different cache stores when using multiple cache drivers.
  ///
  /// - Parameter [storeName] The name of the cache store.
  /// - Returns: A new instance of [CacheDriver] associated with the specified [storeName].
  /// Usage:
  /// ```dart
  /// var myCacheDriver = Cache.store("myStore");
  /// ```
  static BondCache store(String storeName) =>
      sl<BondCache>(instanceName: storeName);

  /// Clears all cached data in the cache store.
  ///
  /// Usage:
  /// ```dart
  /// await Cache.clear();
  /// ```
  static Future<void> clear() async => await cacheDriver.flush();
}
