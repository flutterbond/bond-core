import 'package:bond_network/bond_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final converter = DoubleConverter();

  group('DoubleConverter', () {
    test('should return null when default value is null', () {
      final converter = DoubleConverter(defaultValue: null);
      expect(converter.fromJson(''), null);
    });

    test('should return double when input is int', () {
      expect(converter.fromJson(2), 2.0);
    });

    test('should return double when input is double', () {
      expect(converter.fromJson(2.0), 2.0);
    });

    test('should return double when input is String', () {
      expect(converter.fromJson('2'), 2.0);
      expect(converter.fromJson('2.0'), 2.0);
    });

    test('should return default value when input is invalid String', () {
      expect(converter.fromJson('invalid'), 0.0);
    });

    test('should return default value when input is null', () {
      expect(converter.fromJson(null), 0.0);
    });

    test('should return default value when input is other types', () {
      expect(converter.fromJson([]), 0.0);
      expect(converter.fromJson({}), 0.0);
    });
  });
}
