import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// A validation rule that checks if a value is required conditionally based on
/// either a condition or the equality of another field's value.
///
/// This rule validates that the input value is required if a specified condition
/// is met or if the value of another field is equal to a specified value.
class RequiredIf<T> extends ValidationRule<T> {
  /// The name of the other field to compare equality against.
  final String? otherFieldName;

  /// The value to compare for equality against the other field's value.
  final dynamic equalTo;

  /// The condition function that determines if the value is required.
  final bool Function()? condition;

  /// Creates a new instance of the [RequiredIf] validation rule based on
  /// the equality of another field's value.
  ///
  /// - [otherFieldName]: The name of the other field to compare equality against (required).
  /// - [equalTo]: The value to compare for equality against the other field's value (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  RequiredIf(this.otherFieldName, {required this.equalTo, String? message})
    : condition = null,
      super(message);

  /// Creates a new instance of the [RequiredIf] validation rule based on a condition.
  ///
  /// - [condition]: The condition function that determines if the value is required (required).
  /// - [message]: A custom validation message (optional) to be displayed
  ///   when the validation fails.
  RequiredIf.condition(this.condition, {String? message})
    : otherFieldName = null,
      equalTo = null,
      super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.requiredValidationMessage(fieldName);

  /// Expose whether the field *should be required* given the current form state.
  bool isRequired(Map<String, FormFieldState> fields) {
    if (condition != null) return condition!();
    if (otherFieldName != null) {
      return fields[otherFieldName!]?.value == equalTo;
    }
    return false;
  }

  @override
  bool validate(T value, Map<String, FormFieldState> fields) {
    bool isBlank(dynamic value) {
      if (value == null) return true;
      if (value is String) return value.trim().isEmpty;
      if (value is Iterable) return value.isEmpty;
      return false;
    }

    final requiredNow = isRequired(fields);
    if (!requiredNow) {
      // Not required => always pass
      return true;
    }
    // Required => must be non-empty
    return !isBlank(value);
  }
}
