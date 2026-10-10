import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of a checkbox form field.
///
/// A checkbox form field extends the [FormFieldState] class, adding support for
/// handling the state of a checkbox input.
class CheckboxFieldState<T> extends FormFieldState<T> {
  /// Creates a new instance of [CheckboxFieldState].
  ///
  /// - [value]: The initial value of the checkbox (checked or unchecked).
  /// - [label]: The label or name of the checkbox form field (required).
  /// - [rules]: The list of validation rules to apply to the checkbox field (default is an empty list).
  CheckboxFieldState(T value, {required super.label, super.error, super.rules})
    : super(value: value);

  @override
  CheckboxFieldState<T> copyWith({
    T? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return CheckboxFieldState<T>(
      value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }

  @override
  CheckboxFieldState<T> updateError(String? error) {
    return CheckboxFieldState<T>(
      value,
      error: error,
      label: label,
      rules: rules,
    );
  }

  @override
  CheckboxFieldState<T> copyWithNullable({T? value}) {
    return CheckboxFieldState<T>(
      value as T,
      error: error,
      label: label,
      rules: rules,
    );
  }
}
