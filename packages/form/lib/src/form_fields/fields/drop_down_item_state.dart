import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of an individual item within a dropdown (select) field.
///
/// A `DropDownItemState` extends the [FormFieldState] class, providing
/// a way to manage the state of an item within a dropdown input.
class DropDownItemState<T> extends FormFieldState<T> {
  /// Creates a new instance of [DropDownItemState].
  ///
  /// - [value]: The value associated with the dropdown item (required).
  /// - [label]: The label or name of the dropdown item (required).
  DropDownItemState(T value, {required super.label})
    : super(value: value, rules: const []);

  @override
  DropDownItemState<T> copyWith({
    T? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return DropDownItemState<T>(
      value ?? this.value,
      label: label ?? this.label,
    );
  }

  @override
  DropDownItemState<T> updateError(String? error) => copyWith(error: error);
}
