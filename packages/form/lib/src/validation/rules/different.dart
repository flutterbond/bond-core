import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if the value of the current field is different from another field's value.
///
/// This rule validates that the value of the current field is not equal to the value of another specified field.
class Different<T> extends ValidationRule<T> {
  /// The name of the other field to compare against.
  final String otherField;

  /// Creates a new instance of the [Different] validation rule.
  ///
  /// - [otherField]: The name of the other field to compare against (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Different(this.otherField, {String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.differentValidationMessage(fieldName, otherField);

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    if (!fields.containsKey(otherField)) {
      throw ArgumentError('No field found with name $otherField');
    }

    return value != fields[otherField]?.value;
  }
}

/// Factory function for creating a [Different] validation rule.
Different<T> different<T>(String otherField, {String? message}) =>
    Different<T>(otherField, message: message);
