import 'package:async/async.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'helpers/mock_observer.dart';

void main() {
  group('Stream method Tests', () {
    late CacheObservableMixin cache;

    setUp(() {
      cache = CacheObservableMixin();
    });

    test('Reuse existing observer stream', () async {
      var key = 'test_key';

      final stream1 = cache.stream<int>(key);
      final stream2 = cache.stream<int>(key);

      // Use StreamQueue to listen to streams
      final queue1 = StreamQueue<int>(stream1);
      final queue2 = StreamQueue<int>(stream2);

      // Simulate an event
      cache.notifyObservers(key, 42);

      // Check that both streams emit the same sequence
      await expectLater(queue1.next, completion(42));
      await expectLater(queue2.next, completion(42));

      await queue1.cancel();
      await queue2.cancel();
    });

    test('Not reuse observers rather than ICacheObserver', () {
      final key = 'test_key';

      cache.watch(key, MockObserver());

      expect(cache.observers[key]?.length, equals(1));

      cache.stream<int>(key);

      expect(cache.observers[key]?.length, equals(2));
    });

    test('Stream emits updates on data change', () async {
      final key = 'test_key';

      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);

      expect(await streamListener.next, 42);
      await streamListener.cancel();
    });

    test('Stream still emits on key deletion', () async {
      final key = 'test_key';

      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);
      cache.notifyDeleteObservers(key);
      cache.notifyObservers<int>(key, 44);

      expect(await streamListener.next, 42);
      expect(await streamListener.hasNext, isTrue);
      expect(await streamListener.next, 44);

      await streamListener.cancel();
    });

    test(
      'Steam throws ArgumentError when use the same key with a different type',
      () async {
        final key = 'consistent_key';

        // Initially use the key with integers
        cache.watch<int>(key, MockObserver<int>());
        final intStream = cache.stream<int>(key);
        final intQueue = StreamQueue<int>(intStream);

        // Notify an integer value
        cache.notifyObservers<int>(key, 42);
        expect(await intQueue.next, 42);

        // Attempt to use the same key with a different type (e.g., String)
        // Since the system should block this, the existing int stream should not be affected.
        expect(() => cache.stream<String>(key), throwsA(isA<ArgumentError>()));

        // Further confirm no new values or types are pushed to the int stream
        cache.notifyObservers<int>(key, 43);
        expect(await intQueue.next, 43);

        await intQueue.cancel();
      },
    );

    test('key can be watched and streamed at the same time', () async {
      final key = 'test';

      final observer = MockObserver<int>();
      cache.watch<int>(key, observer);

      final stream = cache.stream<int>(key);
      final streamQueue = StreamQueue<int>(stream);

      cache.notifyObservers<int>(key, 42);

      expect(await streamQueue.next, 42);
      verify(observer.onUpdate(key, 42)).called(1);
    });

    test(
      'Stream emits updates on data change with multiple observers',
      () async {
        final key = 'test_key';

        final observer1 = MockObserver<int>();
        final observer2 = MockObserver<int>();

        cache.watch<int>(key, observer1);
        cache.watch<int>(key, observer2);

        final stream = cache.stream<int>(key);
        final streamListener = StreamQueue<int>(stream);

        cache.notifyObservers<int>(key, 42);

        expect(await streamListener.next, 42);
        verify(observer1.onUpdate(key, 42)).called(1);
        verify(observer2.onUpdate(key, 42)).called(1);

        await streamListener.cancel();
      },
    );

    test('Unwatch remove stream observer and close controller', () async {
      final key = 'test_key';

      // Setup the stream and begin listening to it
      final stream = cache.stream<int>(key);
      final streamListener = StreamQueue<int>(stream);

      // Simulate adding a value to trigger the stream
      cache.notifyObservers<int>(key, 42);
      expect(
        await streamListener.next,
        equals(42),
        reason: 'Stream should receive initial value',
      );

      // Now unwatch the observer and expect the stream to be closed
      cache.unwatch<int>(key);

      // Simulate another update to verify the observer is no longer receiving updates
      cache.notifyObservers<int>(key, 43);

      // Verify that the stream does not receive new updates and is closed
      var isStreamClosed = false;
      stream.listen((_) {}, onDone: () => isStreamClosed = true);

      // Allow time for any pending events to be processed
      await Future.delayed(Duration(milliseconds: 100));

      // Check if stream is closed
      expect(
        isStreamClosed,
        isTrue,
        reason: 'Stream should be closed after unwatch',
      );

      // Finally, clean up the stream listener
      await streamListener.cancel();
    });
  });
}
