import 'package:bond_form/bond_form.dart';
import 'package:test/test.dart';

void main() {
  final pivot = DateTime(2024, 1, 15);
  final earlier = DateTime(2024, 1, 14);
  final later = DateTime(2024, 1, 16);

  group('Rules.dateAfter', () {
    final rule = Rules.dateAfter(pivot);

    test('builds a DateAfter rule', () {
      expect(rule, isA<DateAfter>());
    });

    test('accepts a later date', () {
      expect(rule.validate(later, {}), isTrue);
    });

    test('rejects an earlier date', () {
      expect(rule.validate(earlier, {}), isFalse);
    });
  });

  group('Rules.dateBefore', () {
    final rule = Rules.dateBefore(pivot);

    test('builds a DateBefore rule', () {
      expect(rule, isA<DateBefore>());
    });

    test('accepts an earlier date and rejects a later one', () {
      expect(rule.validate(earlier, {}), isTrue);
      expect(rule.validate(later, {}), isFalse);
    });
  });
}
