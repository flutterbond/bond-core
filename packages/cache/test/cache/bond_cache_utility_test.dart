import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/mock_service_provider.dart';
import 'helpers/mock_cache_driver.dart';

void main() {
  late MockCacheDriver mockDriver;
  late BondCache cache;

  final mockedServiceProvider = MockServiceProvider();

  setUp(() {
    appProviders.add(mockedServiceProvider);
    mockDriver = MockCacheDriver();
    cache = BondCache(driver: mockDriver);
  });

  tearDown(() => appProviders.clear());

  group('flush', () {
    test('returns true when cache is flushed', () async {
      when(mockDriver.removeAll()).thenAnswer((_) async => true);

      final result = await cache.flush();
      expect(result, isTrue);
    });

    test('returns false when cache is not flushed', () async {
      when(mockDriver.removeAll()).thenAnswer((_) async => false);

      final result = await cache.flush();
      expect(result, isFalse);
    });
  });

  group('has', () {
    test('returns true when key exists', () {
      when(mockDriver.has(any)).thenReturn(true);

      final result = cache.has('key');
      expect(result, isTrue);
    });

    test('returns false when key does not exist', () {
      when(mockDriver.has(any)).thenReturn(false);

      final result = cache.has('key');
      expect(result, isFalse);
    });
  });
}
