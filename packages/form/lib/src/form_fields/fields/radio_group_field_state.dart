import 'package:bond_form/bond_form.dart';

/// Represents the state of a group of radio buttons form fields.
///
/// A radio button group form field extends the [FormFieldState] class, providing
/// a way to manage the state of multiple radio buttons within a group.
class RadioGroupFieldState<T> extends FormFieldState<T> {
  /// The list of individual radio button field states within the group.
  final List<RadioButtonFieldState<T>> radioButtons;

  /// Creates a new instance of [RadioGroupFieldState].
  ///
  /// - [radioButtons]: The list of individual radio button field states within the group (required).
  /// - [label]: The label or name of the radio button group form field (required).
  /// - [value]: The initial value of the radio button group (default is `null`).
  /// - [rules]: The list of validation rules to apply to the radio button group field (default is an empty list).
  RadioGroupFieldState(
    this.radioButtons, {
    required super.label,
    required super.value,
    super.error,
    super.rules,
  });

  @override
  RadioGroupFieldState<T> copyWith({
    T? value,
    List<RadioButtonFieldState<T>>? radioButtons,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
  }) {
    return RadioGroupFieldState<T>(
      radioButtons ?? this.radioButtons,
      value: value ?? this.value,
      error: error ?? this.error,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }

  @override
  RadioGroupFieldState<T> updateError(String? error) {
    return RadioGroupFieldState<T>(
      radioButtons,
      value: value,
      error: error,
      label: label,
      rules: rules,
    );
  }

  @override
  RadioGroupFieldState<T> copyWithNullable({T? value}) {
    return RadioGroupFieldState<T>(
      radioButtons,
      value: value as T,
      error: error,
      label: label,
      rules: rules,
    );
  }
}
