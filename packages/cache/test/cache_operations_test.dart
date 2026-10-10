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

  group('put, putAll', () {
    test('putAll method stores list of values in cache', () async {
      final key = 'test_key';
      final value = ['new_value1', 'new_value2'];

      final result = await Cache.putAll<String>(key, value);
      expect(result, isTrue);

      final storedValue = Cache.cacheDriver.getAll<String>(key);
      expect(storedValue, equals(value));
    });

    test('put method stores value in cache', () async {
      final key = 'test_key';
      final value = 'new_value';

      final result = await Cache.put<String>(key, value);
      expect(result, isTrue);

      final storedValue = Cache.cacheDriver.get<String>(key);
      expect(storedValue, equals(value));
    });
  });

  group('get, getAll', () {
    test('get method returns cached value if present', () {
      final key = 'test_key';
      final value = 'cached_value';

      Cache.put<String>(key, value);

      final result = Cache.get<String>(key);
      expect(result, equals(value));
    });

    test('get method returns default value if not present', () {
      final key = 'test_key';
      final defaultValue = 'default_value';

      final result = Cache.get<String>(key, defaultValue: defaultValue);
      expect(result, equals(defaultValue));
    });

    test('get method uses fromJsonFactory to deserialize object', () {
      final key = 'object_key';
      final value = NotRegisteredModel.data('object_value');

      Cache.put<NotRegisteredModel>(key, value);

      final result = Cache.get<NotRegisteredModel>(
        key,
        fromJsonFactory: NotRegisteredModel.fromJson,
      );
      expect(result, equals(value));
    });

    test('get method uses providers to deserialize object', () {
      final key = 'object_key';
      final value = RegisteredModel.data('object_value');

      Cache.put<RegisteredModel>(key, value);

      final result = Cache.get<RegisteredModel>(key);
      expect(result, equals(value));
    });

    test('getAll method returns cached list if present', () {
      final key = 'test_key';
      final value = ['cached_value'];

      Cache.putAll<String>(key, value);

      final result = Cache.getAll<String>(key);
      expect(result, equals(value));
    });

    test('getAll method returns default list if not present', () {
      final key = 'test_key';
      final defaultValue = ['default_value'];

      final result = Cache.getAll<String>(key, defaultValue: defaultValue);
      expect(result, equals(defaultValue));
    });

    test('getAll method uses fromJsonFactory to deserialize list', () {
      final key = 'list_key';
      final value = [NotRegisteredModel.data('list_value')];

      Cache.putAll<NotRegisteredModel>(key, value);

      final result = Cache.getAll<NotRegisteredModel>(
        key,
        fromJsonFactory: NotRegisteredModel.fromJson,
      );
      expect(result, equals(value));
    });

    test('getAll method uses providers to deserialize list', () {
      final key = 'list_key';
      final value = [RegisteredModel.data('list_value')];

      Cache.putAll<RegisteredModel>(key, value);

      final result = Cache.getAll<RegisteredModel>(key);
      expect(result, equals(value));
    });
  });

}
