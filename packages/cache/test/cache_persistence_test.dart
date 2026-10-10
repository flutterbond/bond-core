import 'package:bond_cache/bond_cache.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock class for simulating network fetch or database read operations
class MockFetchFunction extends Mock {
  Future<String> fetchUserFromApi() => super.noSuchMethod(
    Invocation.method(#fetchUserFromApi, []),
    returnValue: Future.value(''),
  );
}

void main() {
  late MockFetchFunction mockFunction;

  setUp(() {
    Cache.cacheDriver = BondCache(driver: InMemoryCacheDriver());
    mockFunction = MockFetchFunction();
  });

  group('remember and rememberForever', () {
    test('remember stores value with expiration', () async {
      final key = 'user';
      final fetchedValue = 'SALAH';

      when(mockFunction.fetchUserFromApi())
          .thenAnswer((_) async => fetchedValue);

      // Call remember method
      await Cache.remember<String>(
        key,
        Duration(days: 1),
        mockFunction.fetchUserFromApi,
      );

      // Check if function was called
      verify(mockFunction.fetchUserFromApi()).called(1);

      // Check if value is stored
      final storedValue = Cache.get<String>(key);
      expect(storedValue, equals(fetchedValue));
    });

    test('remember sets expiration correctly and value expires', () async {
      final key = 'expiry_key';
      final value = 'value_to_expire';

      await Cache.remember<String>(
        key,
        Duration(milliseconds: 100),
        () async => value,
      );

      // Initially check the value is there
      var storedValue = Cache.get<String?>(key);
      expect(storedValue, equals(value));

      // Wait for more than the expiration duration
      await Future.delayed(Duration(milliseconds: 200));

      // Check that the value has expired
      storedValue = Cache.get<String?>(key);
      expect(storedValue, isNull);
    });

    test('rememberForever stores value indefinitely', () async {
      final key = 'user';
      final fetchedValue = 'SALAH';
      when(mockFunction.fetchUserFromApi())
          .thenAnswer((_) async => fetchedValue);

      // Call rememberForever method
      await Cache.rememberForever<String>(key, mockFunction.fetchUserFromApi);

      // Check if function was called
      verify(mockFunction.fetchUserFromApi()).called(1);

      // Check if value is stored
      final storedValue = Cache.get<String>(key);
      expect(storedValue, equals(fetchedValue));
    });
  });
}
