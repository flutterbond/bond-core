import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

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

  group('forget', () {
    test('returns true when key exists', () async {
      when(mockDriver.remove(any)).thenAnswer((_) async => true);

      final result = await cache.forget('key');
      expect(result, isTrue);
    });

    test('returns false when key does not exist', () async {
      when(mockDriver.remove(any)).thenAnswer((_) async => false);

      final result = await cache.forget('key');
      expect(result, isFalse);
    });
  });
}
