import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:intl/intl.dart';

/// A validation rule that checks if a date is after a specified date.
///
/// This rule validates that the input date is chronologically after a specified date.
class DateAfter extends ValidationRule<DateTime> {
  /// The date to compare against.
  final DateTime date;

  /// Creates a new instance of the [DateAfter] validation rule.
  ///
  /// - [date]: The date to compare against (required).
  DateAfter(this.date, {String? message}) : super(message);

  /// Creates a new instance of the [DateAfter] validation rule from a string representation.
  ///
  /// - [date]: The date string to parse and compare against.
  /// - [format]: The format of the date string (optional).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  DateAfter.fromString(String date, {String? format, String? message})
    : date = DateFormat(format).parse(date),
      super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.dateAfterValidationMessage(fieldName, date.toIso8601String());

  @override
  bool validate(DateTime value, Map<String, FormFieldState> fields) {
    return value.isAfter(date);
  }
}
