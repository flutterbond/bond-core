import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';

/// Represents the state of a hidden field.
///
/// A `HiddenFieldState` extends the [FormFieldState] class, providing
/// a way to manage the state of a hidden input.
class HiddenFieldState<T> extends FormFieldState<T> {
  /// Creates a new instance of [HiddenFieldState].
  ///
  /// - [value] The value associated with the hidden field (optional).
  HiddenFieldState(T value, {super.rules}) : super(value: value, label: '');

  @override
  HiddenFieldState<T> copyWith({
    T? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return HiddenFieldState<T>(value ?? this.value, rules: rules ?? this.rules);
  }

  @override
  HiddenFieldState<T> copyWithNullable({T? value}) {
    return HiddenFieldState<T>(value as T, rules: rules);
  }

  @override
  HiddenFieldState<T> updateError(String? error) => copyWith(error: error);
}
