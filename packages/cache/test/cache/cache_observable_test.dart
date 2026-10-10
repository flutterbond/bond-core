import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/mock_observer.dart';

void main() {
  group('CacheObservable Tests', () {
    late CacheObservableMixin cache;
    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Observers are added correctly', () {
      final key = 'test_key';

      // Create an observer and watch the key
      final observer = MockObserver();
      cache.watch(key, observer);

      // Verify that the observer is watching the key
      expect(cache.observers[key]?.containsObserver(observer), isTrue);
    });

    test('Observer limit is enforced', () {
      final key = 'test_key';

      // Add more observers than the limit
      for (var i = 0; i < cache.maxObserversPerKey + 2; i++) {
        var observer = MockObserver();
        cache.watch(key, observer);
      }

      // Verify that the number of observers is equal to the limit
      expect(cache.observers[key]?.length, cache.maxObserversPerKey);
    });

    test('Observers are removed correctly', () {
      final key = 'test_key';

      // Create an observer and watch the key
      final observer = MockObserver();
      cache.watch(key, observer);

      // unwatch the observer
      cache.unwatch(key, observer);

      // Verify that the observer is no longer watching the key
      expect(cache.observers[key]?.contains(observer), isFalse);
    });

    test('Observers are removed when called unwatch with null observer', () {
      final key = 'test_key';

      // Create two observers and watch the key
      final observer1 = MockObserver();
      final observer2 = MockObserver();
      cache.watch(key, observer1);
      cache.watch(key, observer2);

      // Verify that both observers are watching the key
      expect(cache.observers[key]?.length, equals(2));

      // Remove all observers for the key
      cache.unwatch(key);

      // Verify that the observers are no longer watching the key
      expect(cache.observers[key], isNull);
    });
  });

  group('CacheObserver Notification Tests', () {
    late CacheObservableMixin cache;

    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Observer calls onUpdate when notified of a change', () {
      final key = 'test_key';
      final newValue = 'newValue';

      // Create an observer and watch the key
      final observer = MockObserver<String>();
      cache.watch<String>(key, observer);

      // Notify the observer that the key has been updated
      cache.notifyObservers(key, newValue);

      // Verify that onUpdate was called with the correct key and value
      verify(observer.onUpdate(key, newValue)).called(1);
    });

    test('Observer calls onDelete when a key is deleted', () {
      var key = 'test_key';

      final observer = MockObserver<String>();

      cache.watch<String>(key, observer);
      cache.notifyDeleteObservers(key);

      // Verify that onDelete was called with the correct key
      verify(observer.onDelete(key)).called(1);
    });

    test('Observer does not removed when a key is deleted', () {
      final key = 'test_key';

      // Create an observer and watch the key
      final observer = MockObserver<int>();
      cache.watch<int>(key, observer);

      // Notify the observer that the key has been deleted
      cache.notifyDeleteObservers(key);

      // Notify the observer that the key has been updated
      cache.notifyObservers(key, 42);

      // Verify that the observer is still watching the key
      expect(cache.observers[key]?.containsObserver(observer), isTrue);
      verify(observer.onDelete(key)).called(1);
    });

    test('Observer does not removed when all keys are deleted', () {
      final key = 'test_key';

      // Create an observer and watch the key
      final observer = MockObserver<int>();
      cache.watch<int>(key, observer);

      // Notify the all observers that all keys have been deleted
      cache.notifyDeleteObservers(CacheObservable.allKeys);
      cache.notifyObservers(key, 42);

      // Verify that the observer is still watching the key
      expect(cache.observers[key]?.containsObserver(observer), isTrue);
      verify(observer.onUpdate(key, 42)).called(1);
    });

    test('Observer Throws ArgumentError on type mismatch'
        ' between notified data and observer', () async {
      final key = 'test_key';

      // Create a mock observer for integers and watch the key
      final observer = MockObserver<int>();
      cache.watch<int>(key, observer);

      // Expect an ArgumentError when trying to notify with a String instead of an int
      expect(
        () => cache.notifyObservers(key, '42'),
        throwsA(isA<ArgumentError>()),
      );

      //  verify no calls were made to the observer's onUpdate due to type mismatch
      verifyNever(observer.onUpdate(key, any));
    });
  });
}
