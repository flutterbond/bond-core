import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of a radio button form field.
///
/// A radio button form field extends the [FormFieldState] class, providing
/// a way to manage the state of a radio button input.
class RadioButtonFieldState<T> extends FormFieldState<T> {
  /// Creates a new instance of [RadioButtonFieldState].
  ///
  /// - [value]: The initial value of the radio button field.
  /// - [label]: The label or name of the radio button form field (required).
  RadioButtonFieldState(T value, {required super.label})
    : super(value: value, rules: []);

  @override
  RadioButtonFieldState<T> copyWith({
    T? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return RadioButtonFieldState<T>(
      value ?? this.value,
      label: label ?? this.label,
    );
  }

  @override
  RadioButtonFieldState<T> updateError(String? error) => copyWith(error: error);
}
