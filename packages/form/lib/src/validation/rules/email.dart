import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:bond_form/src/form_fields/form_field_state.dart';

/// A validation rule that checks if a string represents a valid email address.
///
/// This rule validates that the input string represents a valid email address.
class Email extends ValidationRule<String> {
  /// Creates a new instance of the [Email] validation rule.
  ///
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  Email({String? message}) : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.emailValidationMessage(fieldName);

  @override
  bool validate(String value, Map<String, FormFieldState> fields) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value);
  }
}
