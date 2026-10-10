import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:intl/intl.dart';

/// A validation rule that checks if a date is before a specified date.
///
/// This rule validates that the input date is chronologically before a specified date.
class DateBefore extends ValidationRule<DateTime> {
  /// The date to compare against.
  final DateTime date;

  /// Creates a new instance of the [DateBefore] validation rule.
  ///
  /// - [date]: The date to compare against (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  DateBefore(this.date, {String? message}) : super(message);

  /// Creates a new instance of the [DateBefore] validation rule from a string representation.
  ///
  /// - [dateStr]: The date string to parse and compare against.
  /// - [format]: The format of the date string (default is 'yyyy-MM-dd').
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  DateBefore.fromString(
    String dateStr, {
    String? format = 'yyyy-MM-dd',
    String? message,
  }) : date = DateFormat(format).parse(dateStr),
       super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateBeforeValidationMessage(fieldName, date.toIso8601String());

  @override
  bool validate(DateTime value, Map<String, FormFieldState> fields) {
    return value.isBefore(date);
  }
}
