import 'dart:convert';

import 'package:bond_cache/src/helpers/common_cache_helper.dart';
import 'package:bond_core/bond_core.dart';
import 'package:test/test.dart';

import '../common/custom_object.dart';
import '../common/mock_service_provider.dart';
import '../common/not_registered_model.dart';
import '../common/registered_model.dart';

void main() {
  group('convertToCacheValue', () {
    test('Check for CustomObject', () {
      final value = CustomObject();
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for List<CustomObject>', () {
      final value = [CustomObject(), CustomObject()];
      final result = CommonCacheHelper.convertToCacheValue(value);
      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for int', () {
      final value = 42;
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for double', () {
      final value = 42.0;
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for String', () {
      final value = 'hello';
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for bool', () {
      final value = true;
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for List<int>', () {
      final value = [1, 2, 3];
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for List<double>', () {
      final value = [1.1, 2.2, 3.3];
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for List<String>', () {
      final value = ['one', 'two', 'three'];
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for List<bool>', () {
      final value = [true, false, true];
      final result = CommonCacheHelper.convertToCacheValue(value);

      final expectedData = {
        'data': jsonDecode(jsonEncode(value)),
        'expiredAt': null,
      };
      expect(result, equals(expectedData));
    });

    test('Check for unsupported type', () {
      final value = DateTime.now();
      expect(
        () => CommonCacheHelper.convertToCacheValue(value),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            equals(
              'Unsupported type of value: $value. '
              'Tip: for custom object type must be implement the toJson() method.',
            ),
          ),
        ),
      );
    });
  });

  group('checkCachedData', () {
    final mockedServiceProvider = MockServiceProvider();

    setUp(() => appProviders.add(mockedServiceProvider));

    tearDown(() => appProviders.clear());

    test('Check for int type', () {
      final result = CommonCacheHelper.checkCachedData<int>(42);
      expect(result, equals(42));
    });

    test('Check for double type', () {
      final result = CommonCacheHelper.checkCachedData<double>(42.1);
      expect(result, equals(42.1));
    });

    test('Check for bool type', () {
      final result = CommonCacheHelper.checkCachedData<bool>(true);
      expect(result, equals(true));
    });

    test('Check for String type', () {
      final result = CommonCacheHelper.checkCachedData<String>('SALAH');
      expect(result, equals('SALAH'));
    });

    test('Check for provided factory', () {
      final json = {'data': 'any data'};
      final model = NotRegisteredModel.fromJson(json);
      final result = CommonCacheHelper.checkCachedData<NotRegisteredModel>(
        json,
        fromJsonFactory: NotRegisteredModel.fromJson,
      );
      expect(result, equals(model));
    });

    test('Check for registered type', () {
      final json = {'data': 'any data'};
      final model = RegisteredModel.fromJson(json);
      final result = CommonCacheHelper.checkCachedData<RegisteredModel>(json);
      expect(result, equals(model));
    });

    test('Check for nullable registered type', () {
      final json = {'data': 'any data'};
      final model = RegisteredModel.fromJson(json);
      final result = CommonCacheHelper.checkCachedData<RegisteredModel?>(json);
      expect(result, equals(model));
    });

    test('Check for unregistered ResponseDecoding provider and '
        'not provided factory', () {
      final json = {'data': 'any data'};

      expect(
        () => CommonCacheHelper.checkCachedData<NotRegisteredModel>(json),
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
    });

    test('Check for unsupported type', () {
      final data = DateTime.now();

      expect(
        () => CommonCacheHelper.checkCachedData<DateTime>(data),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            equals('Unhandled case for type DateTime and cached value: $data'),
          ),
        ),
      );
    });

    group('Checking for List', () {
      test('Check for List<int> type', () {
        final result = CommonCacheHelper.convertList<int>([42, 45]);
        expect(result, equals([42, 45]));
      });

      test('Check for List<double> type', () {
        final result = CommonCacheHelper.convertList<double>([42.1, 45.2]);
        expect(result, equals([42.1, 45.2]));
      });

      test('Check for List<bool> type', () {
        final result = CommonCacheHelper.convertList<bool>([true, false]);
        expect(result, equals([true, false]));
      });

      test('Check for List<String> type', () {
        final result = CommonCacheHelper.convertList<String>(['SALAH', 'NB']);
        expect(result, equals(['SALAH', 'NB']));
      });

      test('Check for List of registered type', () {
        final cachedValue = [
          {'data': 'NB'},
          {'data': 'SALAH'},
        ];
        final expectedResult = [
          RegisteredModel.data('NB'),
          RegisteredModel.data('SALAH'),
        ];
        final result = CommonCacheHelper.convertList<RegisteredModel>(
          cachedValue,
        );
        expect(result, equals(expectedResult));
      });

      test('Check for List of provided factory', () {
        final cachedValue = [
          {'data': 'NB'},
          {'data': 'SALAH'},
        ];
        final expectedResult = [
          NotRegisteredModel.data('NB'),
          NotRegisteredModel.data('SALAH'),
        ];
        final result = CommonCacheHelper.convertList<NotRegisteredModel>(
          cachedValue,
          fromJsonFactory: NotRegisteredModel.fromJson,
        );
        expect(result, equals(expectedResult));
      });

      test('throws exception if custom type is not registered and no factory provided', () {
        final cachedValue = [
          {'data': 'NB'},
          {'data': 'SALAH'},
        ];
        expect(
          () => CommonCacheHelper.convertList<NotRegisteredModel>(cachedValue),
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
      });
    });
  });

  group('checkDefaultValue', () {
    test('checkDefaultValue returns the value if it matches the type', () {
      final defaultValue = 42;
      final result = CommonCacheHelper.checkDefaultValue<int>(defaultValue);
      expect(result, equals(defaultValue));
    });

    test('checkDefaultValue returns the value from a function', () {
      int defaultValueFunction() => 42;
      final result = CommonCacheHelper.checkDefaultValue<int>(
        defaultValueFunction,
      );
      expect(result, equals(defaultValueFunction()));
    });

    test('checkDefaultValue throws ArgumentError for incorrect type', () {
      final defaultValue = 'hello';
      expect(
        () => CommonCacheHelper.checkDefaultValue<int>(defaultValue),
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

    test('checkDefaultValue throws ArgumentError for incorrect function return type', () {
      String defaultValueFunction() => 'hello';
      expect(
        () => CommonCacheHelper.checkDefaultValue<int>(defaultValueFunction),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains(
              'defaultValue must be of type int or a function returning int',
            ),
          ),
        ),
      );
    });
  });
}
