import 'dart:io';

import 'package:bond_form/bond_form.dart';

/// Extension methods for [FormController] providing more type-safe updates.
///
/// The `XFormController` extension adds methods to `FormController` to simplify
/// updating the values of various form fields in a type-safe manner.
///
/// Example usage:
/// ```dart
/// // Update the value of a text field.
/// controller.updateText('fieldName', 'new value');
///
/// // Update the value of a checkbox field.
/// controller.updateCheckbox('fieldName', true);
///
/// // Toggle a value in a checkbox group.
/// controller.toggleCheckbox('fieldName', value: 'value', selected: true);
/// ```
///
/// Methods:
/// - [updateText] Updates a [TextFieldState] with a given value.
/// - [updateCheckbox] Updates a [CheckboxFieldState] with a given value.
/// - [updateCheckboxGroup] Updates a [CheckboxGroupFieldState] with a given value.
/// - [toggleCheckbox] Toggles the value of a specific checkbox within a checkbox group.
/// - [updateDate] Updates a [DateFieldState] with a given value.
/// - [updateDropDown] Updates a [DropDownFieldState] with a given value.
/// - [updateAsyncDropDown] Updates a [AsyncDropDownFieldState] with a given value.
/// - [updateRadioButton] Updates a [RadioButtonFieldState] with a given value.
/// - [updateRadioGroup] Updates a [RadioGroupFieldState] with a given value.
/// - [updateAsyncRadioGroup] Updates an [AsyncRadioGroupFieldState] with a given value.
/// - [updateRadioGroupItems] Updates a [RadioGroupFieldState] with a list of [RadioButtonFieldState] items.
/// - [updateHiddenField] Updates a [HiddenFieldState] with a given value.
/// - [updateAsyncHiddenField] Updates an [AsyncHiddenFieldState] with a given value.
/// - [updateFile] Updates a [FileFieldState] with a given value.
extension XFormController on BaseFormController {
  /// Updates a [TextFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the text field to update.
  /// - [value] The new value for the text field.
  void updateText(String fieldName, String? value) {
    updateValue<TextFieldState, String?>(fieldName, value);
  }

  /// Updates a [CheckboxFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the checkbox field to update.
  /// - [value] The new value for the checkbox field.
  void updateCheckbox(String fieldName, bool value) {
    updateValue<CheckboxFieldState<bool>, bool>(fieldName, value);
  }

  /// Updates a [CheckboxGroupFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the checkbox group field to update.
  /// - [value] The new value for the checkbox group field.
  /// throws [ArgumentError] if the generic type T is not specified.
  void updateCheckboxGroup<T>(String fieldName, Set<T> value) {
    updateValue<CheckboxGroupFieldState<T>, Set<T>>(fieldName, value);
  }

  /// Toggles the value of a specific checkbox within a checkbox group.
  ///
  /// Updates the set of selected values for the checkbox group field specified
  /// by [fieldName] to either include or exclude the given [value] based on
  /// the [selected] parameter.
  ///
  /// [fieldName] The name of the field associated with the checkbox group.
  /// [value] The value of the specific checkbox to toggle.
  /// [selected] A boolean indicating whether the checkbox is selected (`true`) or not (`false`).
  /// If `null`, the checkbox will be treated as not selected.
  ///
  /// This method automatically updates the state of the checkbox group field.
  void toggleCheckbox<T>(String fieldName, {required T value, bool? selected}) {
    final currentValues = state.checkboxValues<T>(fieldName);
    if (selected ?? false) {
      currentValues.add(value);
    } else {
      currentValues.remove(value);
    }
    updateCheckboxGroup<T>(fieldName, currentValues);
  }

  /// Updates a [DateFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the date field to update.
  /// - [value] The new value for the date field.
  void updateDate(String fieldName, DateTime? value) {
    updateValue<DateFieldState, DateTime?>(fieldName, value);
  }

  /// Updates a [DropDownFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the dropdown field to update.
  /// - [value] The new value for the dropdown field.
  void updateDropDown<T>(String fieldName, T value) {
    updateValue<DropDownFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [AsyncDropDownFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the async dropdown field to update.
  /// - [value] The new value for the dropdown field.
  void updateAsyncDropDown<T>(String fieldName, T value) {
    updateValue<AsyncDropDownFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [RadioButtonFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the radio button field to update.
  /// - [value] The new value for the radio button field.
  void updateRadioButton<T>(String fieldName, T value) {
    updateValue<RadioButtonFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [RadioGroupFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the radio group field to update.
  /// - [value] The new value for the radio group field.
  void updateRadioGroup<T>(String fieldName, T value) {
    updateValue<RadioGroupFieldState<T>, T>(fieldName, value);
  }

  /// Updates an [AsyncRadioGroupFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the async radio group field to update.
  /// - [value] The new value for the async radio group field.
  void updateAsyncRadioGroup<T>(String fieldName, T value) {
    updateValue<AsyncRadioGroupFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [RadioGroupFieldState] with a list of [RadioButtonFieldState] items.
  ///
  /// - [fieldName] The name of the radio group field to update.
  /// - [items] The new list of radio button items for the radio group.
  void updateRadioGroupItems<T>(
    String fieldName,
    List<RadioButtonFieldState<T>> items,
  ) {
    state.fields[fieldName] = state
        .radioGroup<T>(fieldName)
        .copyWith(radioButtons: items);
  }

  /// Updates a [HiddenFieldState] with a given [value].
  ///
  /// - [fieldName] The name of the hidden field to update.
  /// - [value] The new value for the hidden field.
  void updateHiddenField<T>(String fieldName, T value) {
    updateValue<HiddenFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [AsyncHiddenFieldState] with a given value.
  ///
  /// - [fieldName] The name of the hidden field to update.
  /// - [value] The new value for the hidden field.
  void updateAsyncHiddenField<T>(String fieldName, T value) {
    updateValue<AsyncHiddenFieldState<T>, T>(fieldName, value);
  }

  /// Updates a [FileFieldState] with a given [value].
  /// - [fieldName] The name of the file field to update.
  /// - [value] The new value for the file field.
  void updateFile(String fieldName, File? value) {
    updateValue<FileFieldState, File?>(fieldName, value);
  }
}
