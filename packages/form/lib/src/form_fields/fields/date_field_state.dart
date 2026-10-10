import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of a date input form field.
///
/// A date input form field extends the [FormFieldState] class, providing
/// a way to manage the state of a date input.
class DateFieldState extends FormFieldState<DateTime?> {
  /// Creates a new instance of [DateFieldState].
  ///
  /// - [value]: The initial date value of the field.
  /// - [label]: The label or name of the date input form field (required).
  /// - [rules]: The list of validation rules to apply to the date field (default is an empty list).
  DateFieldState(
    DateTime? value, {
    required super.label,
    super.error,
    super.rules = const [],
  }) : super(value: value);

  @override
  DateFieldState copyWith({
    DateTime? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<DateTime?>>? rules,
  }) {
    return DateFieldState(
      value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }

  @override
  DateFieldState updateError(String? error) {
    return DateFieldState(value, error: error, label: label, rules: rules);
  }

  @override
  DateFieldState copyWithNullable({DateTime? value}) {
    return DateFieldState(value, error: error, label: label, rules: rules);
  }
}
