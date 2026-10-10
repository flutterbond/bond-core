import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

import 'checkbox_field_state.dart';

/// Represents the state of a group of checkbox form fields.
///
/// A checkbox group form field extends the [FormFieldState] class, providing
/// a way to manage the state of multiple checkboxes within a group.
class CheckboxGroupFieldState<T> extends FormFieldState<Set<T>> {
  /// The list of individual checkbox field states within the group.
  final List<CheckboxFieldState<T>> checkboxes;

  /// Creates a new instance of [CheckboxGroupFieldState].
  ///
  /// - [checkboxes]: The list of individual checkbox field states within the group (required).
  /// - [label]: The label or name of the checkbox group form field (required).
  /// - [value]: The initial value of the checkbox group (default is `null`).
  /// - [rules]: The list of validation rules to apply to the checkbox group field (default is an empty list).
  CheckboxGroupFieldState(
    this.checkboxes, {
    required super.label,
    super.error,
    Set<T>? value,
    super.rules = const [],
  }) : super(value: value ?? <T>{});

  @override
  CheckboxGroupFieldState<T> copyWith({
    Set<T>? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<Set<T>>>? rules,
  }) {
    return CheckboxGroupFieldState<T>(
      checkboxes,
      value: value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }

  @override
  CheckboxGroupFieldState<T> updateError(String? error) {
    return CheckboxGroupFieldState<T>(
      checkboxes,
      value: value,
      error: error,
      label: label,
      rules: rules,
    );
  }

  @override
  CheckboxGroupFieldState<T> copyWithNullable({Set<T>? value}) {
    return CheckboxGroupFieldState<T>(
      checkboxes,
      value: value,
      error: error,
      label: label,
      rules: rules,
    );
  }
}
