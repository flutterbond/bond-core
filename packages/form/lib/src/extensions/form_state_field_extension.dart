import 'dart:io';

import 'package:bond_form/bond_form.dart';

/// Extension methods for [BondFormState] providing convenience operations.
///
/// The `FieldBondFormState` extension adds methods to `BondFormState` to simplify
/// retrieving field states from the form state.
///
/// Example usage:
/// ```dart
/// // Retrieve the state of a text field.
/// final phoneNumberFieldState = state.textField('phoneNumber');
/// ```
/// Methods:
/// - [textField] Retrieves the state of a text field.
/// - [radioGroup] Retrieves the state of a radio group field.
/// - [asyncRadioGroup] Retrieves the state of an async radio group field.
/// - [radioButtonsOf] Retrieves a list of radio button states.
/// - [asyncRadioButtonsOf] Retrieves a list of async radio button states.
/// - [checkbox] Retrieves the state of a checkbox field.
/// - [checkboxGroup] Retrieves the state of a checkbox group field.
/// - [checkboxesOf] Retrieves a list of checkbox states.
/// - [dateField] Retrieves the state of a date field.
/// - [dropDownField] Retrieves the state of a dropdown field.
/// - [dropDownItems] Retrieves a list of dropdown items.
/// - [asyncDropDownField] Retrieves the state of an async dropdown field.
/// - [asyncDropDownItems] Retrieves a list of async dropdown items.
/// - [hiddenField] Retrieves the state of a hidden field.
/// - [asyncHiddenField] Retrieves the state of an async hidden field.
/// - [fileField] Retrieves the state of a file field.
extension FieldBondFormState on BaseBondFormState {
  /// Retrieves the [TextFieldState] for a given text field.
  ///
  /// This method simplifies fetching the state of a text field with a specified [fieldName].
  ///
  /// - Parameter [fieldName]: The name of the text field for which the state is to be fetched.
  /// - Returns: The [TextFieldState] corresponding to the given [fieldName].
  /// - Throws: [ArgumentError] if the field doesn't exist.
  TextFieldState textField(String fieldName) {
    return get<TextFieldState, String?>(fieldName);
  }

  /// Retrieves the state of the radio group field for a specified [fieldName].
  ///
  /// This method retrieves the state of the radio group field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the radio group field to retrieve the state from.
  /// - Returns: The state of the radio group field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  RadioGroupFieldState<T> radioGroup<T>(String fieldName) {
    return get<RadioGroupFieldState<T>, T>(fieldName);
  }

  /// Retrieves the state of the async radio group field for a specified [fieldName].
  ///
  /// This method retrieves the state of the async radio group field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async radio group field to retrieve the state from.
  /// - Returns: The state of the async radio group field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  AsyncRadioGroupFieldState<T> asyncRadioGroup<T>(String fieldName) {
    return get<AsyncRadioGroupFieldState<T>, T>(fieldName);
  }

  /// Retrieves a list of [RadioButtonFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching radio button states for the given [fieldName].
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A list of [RadioButtonFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<RadioButtonFieldState<T>> radioButtonsOf<T>(String fieldName) {
    return radioGroup<T>(fieldName).radioButtons;
  }

  /// Retrieves a list of [RadioButtonFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching async radio button states for the given [fieldName].
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A list of [RadioButtonFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  Future<List<RadioButtonFieldState<T>>> asyncRadioButtonsOf<T>(
    String fieldName,
  ) {
    return asyncRadioGroup<T>(fieldName).resolvedItems;
  }

  /// Retrieves the state of the checkbox field for a specified [fieldName].
  ///
  /// This method retrieves the state of the checkbox field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the checkbox field to retrieve the state from.
  /// - Returns: The state of the checkbox field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  CheckboxFieldState<bool> checkbox(String fieldName) {
    return get<CheckboxFieldState<bool>, bool>(fieldName);
  }

  /// Retrieves the state of the checkbox group field for a specified [fieldName].
  ///
  /// This method retrieves the state of the checkbox group field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the checkbox group field to retrieve the state from.
  /// - Returns: The state of the checkbox group field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  CheckboxGroupFieldState<T> checkboxGroup<T>(String fieldName) {
    return get<CheckboxGroupFieldState<T>, Set<T>>(fieldName);
  }

  /// Retrieves a list of [CheckboxFieldState] for a specified [fieldName].
  ///
  /// This method simplifies fetching checkbox states for the given [fieldName].
  ///
  /// - Parameter [fieldName] The name of the field to fetch.
  /// - Returns: A list of [CheckboxFieldState] instances.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<CheckboxFieldState<T>> checkboxesOf<T>(String fieldName) {
    return checkboxGroup<T>(fieldName).checkboxes;
  }

  /// Retrieves the state of the date field for a specified [fieldName].
  ///
  /// This method retrieves the state of the date field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the date field to retrieve the state from.
  /// - Returns: The state of the date field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  DateFieldState dateField(String fieldName) {
    return get<DateFieldState, DateTime?>(fieldName);
  }

  /// Retrieves the state of the dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the state of the dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve the state from.
  /// - Returns: The state of the dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  DropDownFieldState<T> dropDownField<T>(String fieldName) {
    return get<DropDownFieldState<T>, T>(fieldName);
  }

  /// Retrieves the list of dropdown items for a specified [fieldName].
  ///
  /// This method retrieves the list of dropdown items associated with the
  /// dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the dropdown field to retrieve items from.
  /// - Returns: A list of [DropDownItemState] representing the items of the dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  List<DropDownItemState<T>> dropDownItems<T>(String fieldName) {
    return dropDownField<T>(fieldName).items;
  }

  /// Retrieves the state of the async dropdown field for a specified [fieldName].
  ///
  /// This method retrieves the state of the async dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve the state from.
  /// - Returns: The state of the async dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  AsyncDropDownFieldState<T> asyncDropDownField<T>(String fieldName) {
    return get<AsyncDropDownFieldState<T>, T>(fieldName);
  }

  /// Retrieves the list of dropdown items for a specified [fieldName].
  ///
  /// This method retrieves the list of async dropdown items associated with the
  /// async dropdown field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async dropdown field to retrieve items from.
  /// - Returns: A list of [DropDownItemState] representing the items of the async dropdown field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  Future<List<DropDownItemState<T>>> asyncDropDownItems<T>(String fieldName) {
    return asyncDropDownField<T>(fieldName).resolvedItems;
  }

  /// Retrieves the hidden field state for a specified [fieldName].
  ///
  /// - Parameter [fieldName] The name of the hidden field to fetch.
  /// - Returns: The hidden field state.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  HiddenFieldState<T> hiddenField<T>(String fieldName) {
    return get<HiddenFieldState<T>, T>(fieldName);
  }

  /// Retrieves the async hidden field state for a specified [fieldName].
  ///
  /// - Parameter [fieldName] The name of the async hidden field to fetch.
  /// - Returns: The async hidden field state.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  AsyncHiddenFieldState<T> asyncHiddenField<T>(String fieldName) {
    return get<AsyncHiddenFieldState<T>, T>(fieldName);
  }

  /// Retrieves the state of the file field for a specified [fieldName].
  ///
  /// This method retrieves the state of the file field identified by the provided [fieldName].
  ///
  /// - Parameter [fieldName] The name of the file field to retrieve the state from.
  /// - Returns: The state of the file field.
  /// - Throws: [ArgumentError] if the field doesn't exist.
  FileFieldState fileField(String fieldName) {
    return get<FileFieldState, File?>(fieldName);
  }
}
