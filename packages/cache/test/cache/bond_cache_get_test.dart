import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../common/custom_object.dart';
import '../common/mock_service_provider.dart';
import '../common/not_registered_model.dart';
import '../common/registered_model.dart';
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

  group('get', () {
    group('default value', () {
      test('returns defaultValue and remove the key'
          ' when key exists but null', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': null, 'expiredAt': null},
        );
        mockDriver.whenRemoveThenAnswer(key: 'existing_key', answer: true);

        final result = cache.get<int>('existing_key', defaultValue: 42);

        expect(result, equals(42));
        verify(mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue when key does not exist', () {
        mockDriver.whenHasThenReturn(
          key: 'not_existing_key',
          returnValue: false,
        );

        final result = cache.get<int>('not_existing_key', defaultValue: 42);

        expect(result, equals(42));
      });

      test('returns defaultValue and remove the key'
          ' when key exists but expired', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': 42, 'expiredAt': 1000},
        );
        mockDriver.whenRemoveThenAnswer(key: 'existing_key', answer: true);

        final result = cache.get<int>('existing_key', defaultValue: 42);

        expect(result, equals(42));
        verify(mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue from function', () {
        when(mockDriver.has(any)).thenReturn(true);
        when(mockDriver.retrieve(any)).thenReturn(null);

        final result = cache.get<int>('existing_key', defaultValue: () => 42);

        expect(result, equals(42));
      });

      test('throws ArgumentError for incorrect default value type', () {
        when(mockDriver.has(any)).thenReturn(false);
        expect(
          () => cache.get<int>('key', defaultValue: '42'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              equals(
                'defaultValue must be of type int or a function returning int',
              ),
            ),
          ),
        );
      });

      test('returns null when key does not exist for nullable type', () {
        when(mockDriver.has(any)).thenReturn(false);
        final result = cache.get<CustomObject?>('key');
        expect(result, isNull);
      });

      test('throws an error when key does not exist for non-nullable type', () {
        when(mockDriver.has(any)).thenReturn(false);
        expect(
          () => cache.get<String>('key'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains(
                'defaultValue must be of type String or a function returning String',
              ),
            ),
          ),
        );
      });
    });

    group('primitive types', () {
      test('returns cached int value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = 42;
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.get<int>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached double value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = 42.0;
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.get<double>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached bool value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = true;
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.get<bool>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached String value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = 'SALAH';
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.get<String>('existing_key');

        expect(result, equals(data));
      });
    });

    group('custom types', () {
      test('returns cached registered type when key exists and is valid', () {
        final json = {'data': 'SALAH'};
        final data = RegisteredModel.fromJson(json);

        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': {'data': 'SALAH'},
            'expiredAt': null,
          },
        );

        final result = cache.get<RegisteredModel>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached provided type when key exists and is valid', () {
        final json = {'data': 'SALAH'};
        final data = NotRegisteredModel.fromJson(json);

        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': {'data': 'SALAH'},
            'expiredAt': null,
          },
        );

        final result = cache.get<NotRegisteredModel>(
          'existing_key',
          fromJsonFactory: NotRegisteredModel.fromJson,
        );

        expect(result, equals(data));
      });

      test(
        'throws an argument error exception for unregistered cached type',
        () {
          final json = {'data': 'SALAH'};
          final cachedData = {'data': json, 'expiredAt': null};
          mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
          mockDriver.whenRetrieveThenReturn(
            key: 'existing_key',
            cachedData: cachedData,
          );

          expect(
            () => cache.get<NotRegisteredModel>('existing_key'),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains(
                  'No ResponseDecoding provider found for type NotRegisteredModel',
                ),
              ),
            ),
          );
        },
      );
    });
  });

  group('get all', () {
    group('default value', () {
      test('returns defaultValue and remove the key'
          ' when key exists but null', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': null, 'expiredAt': null},
        );
        mockDriver.whenRemoveThenAnswer(key: 'existing_key', answer: true);

        final result = cache.getAll<int>('existing_key', defaultValue: [42]);

        expect(result, equals([42]));
        verify(mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue when key does not exist', () {
        mockDriver.whenHasThenReturn(
          key: 'not_existing_key',
          returnValue: false,
        );

        final result = cache.getAll<int>(
          'not_existing_key',
          defaultValue: [42],
        );

        expect(result, equals([42]));
      });

      test('returns defaultValue and remove the key'
          ' when key exists but expired', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': 42, 'expiredAt': 1000},
        );
        mockDriver.whenRemoveThenAnswer(key: 'existing_key', answer: true);

        final result = cache.getAll<int>('existing_key', defaultValue: [42]);

        expect(result, equals([42]));
        verify(mockDriver.remove('existing_key')).called(1);
      });

      test('returns defaultValue from function', () {
        mockDriver.whenHasThenReturn(returnValue: true);
        mockDriver.whenRetrieveThenReturn(cachedData: null);

        final result = cache.getAll<int>(
          'existing_key',
          defaultValue: () => [42],
        );

        expect(result, equals([42]));
      });

      test('throws ArgumentError for incorrect default value type', () {
        mockDriver.whenHasThenReturn(returnValue: false);
        expect(
          () => cache.getAll<int>('key', defaultValue: ['42']),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              equals(
                'defaultValue must be of type List<int> or a function returning List<int>',
              ),
            ),
          ),
        );
      });
    });

    group('primitive types', () {
      test('returns cached int value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = [42, 44];
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.getAll<int>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached double value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = [42.0, 44.0];
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.getAll<double>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached bool value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = [true, false];
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.getAll<bool>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached String value when key exists and is valid', () {
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        final data = ['SALAH', 'NB'];
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {'data': data, 'expiredAt': null},
        );

        final result = cache.getAll<String>('existing_key');

        expect(result, equals(data));
      });
    });

    group('custom types', () {
      test('returns cached registered type when key exists and is valid', () {
        final json = {'data': 'SALAH'};
        final json2 = {'data': 'NB'};
        final data = [
          RegisteredModel.fromJson(json),
          RegisteredModel.fromJson(json2),
        ];
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': [json, json2],
            'expiredAt': null,
          },
        );

        final result = cache.getAll<RegisteredModel>('existing_key');

        expect(result, equals(data));
      });

      test('returns cached provided type when key exists and is valid', () {
        final json = {'data': 'SALAH'};
        final json2 = {'data': 'NB'};
        final data = [
          NotRegisteredModel.fromJson(json),
          NotRegisteredModel.fromJson(json2),
        ];
        mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
        mockDriver.whenRetrieveThenReturn(
          key: 'existing_key',
          cachedData: {
            'data': [json, json2],
            'expiredAt': null,
          },
        );

        final result = cache.getAll<NotRegisteredModel>(
          'existing_key',
          fromJsonFactory: NotRegisteredModel.fromJson,
        );

        expect(result, equals(data));
      });

      test(
        'throws an argument error exception for unregistered cached type',
        () {
          final json = {'data': 'SALAH'};
          final json2 = {'data': 'NB'};
          final cachedData = {
            'data': [json, json2],
            'expiredAt': null,
          };
          mockDriver.whenHasThenReturn(key: 'existing_key', returnValue: true);
          mockDriver.whenRetrieveThenReturn(
            key: 'existing_key',
            cachedData: cachedData,
          );

          expect(
            () => cache.getAll<NotRegisteredModel>('existing_key'),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains(
                  'No ResponseDecoding provider found for type NotRegisteredModel',
                ),
              ),
            ),
          );
        },
      );
    });
  });
}
