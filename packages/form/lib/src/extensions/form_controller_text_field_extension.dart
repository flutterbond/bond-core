import 'package:bond_form/bond_form.dart';
import 'package:flutter/widgets.dart' as widgets;

/// A collection of utilities to work with [TextFieldState] inside [BaseFormController].
///
/// This extension provides access to the `TextEditingController` for a field,
/// ensures it's observed for changes, and allows safe disposal of listeners.

extension TextFieldFormController<
  Success,
  Failure extends Error,
  State extends BaseBondFormState<Success, Failure>
>
    on BaseFormController<Success, Failure, State> {
  /// Retrieves the [TextEditingController] for a given text field and ensures it is observed.
  ///
  /// If a listener hasn't been registered for the given [fieldName], this method
  /// will add one that automatically updates the form state when the controller's text changes.
  ///
  /// - Parameter [fieldName]: The name of the text field to observe.
  /// - Returns: The [TextEditingController] associated with the given [fieldName].
  widgets.TextEditingController textFieldController(String fieldName) {
    final field = state.textField(fieldName);
    _observeTextField(fieldName, field.controller);
    return field.controller;
  }

  /// Retrieves the [FocusNode] for a given text field.
  ///
  /// This is useful for managing focus behavior in the UI, such as moving focus to the next field.
  ///
  /// - Parameter [fieldName]: The name of the text field to get the focus node for.
  /// - Returns: The [FocusNode] associated with the specified text field.
  widgets.FocusNode textFieldFocusNode(String fieldName) {
    final field = state.textField(fieldName);
    _observeTextFieldFocus(fieldName, field.focusNode);
    return field.focusNode;
  }

  /// Adds a listener to the [TextEditingController] of the specified field to update form state.
  ///
  /// This ensures that any user input is reflected in the form state via [updateValue].
  /// If a listener has already been registered for the [fieldName], this method does nothing.
  ///
  /// - Parameters:
  ///   - [fieldName]: The name of the text field to bind.
  ///   - [controller]: The [TextEditingController] instance to observe.
  void _observeTextField(
    String fieldName,
    widgets.TextEditingController controller,
  ) {
    if (textFieldListeners.containsKey(fieldName)) return;

    void listener() {
      updateValue<TextFieldState, String?>(fieldName, controller.text);
    }

    textFieldListeners[fieldName] = listener;
    controller.addListener(listener);
  }

  /// Remove the listener registered for the given text field, if any.
  ///
  /// This is useful when cleaning up resources, such as during `onClose()` in a controller.
  ///
  /// - Parameter [fieldName]: The name of the text field to unbind.
  void removeTextFieldListener(String fieldName) {
    final listener = textFieldListeners.remove(fieldName);
    if (listener != null) {
      final controller = state.textField(fieldName).controller;
      controller.removeListener(listener);
    }
  }

  /// Observes the focus state of a text field and updates the form state on blur.
  ///
  /// - If a listener for [fieldName] is already registered, this is a no-op.
  /// - When focus is lost:
  ///   - Optionally marks the field as touched.
  ///   - Optionally validates the field and updates its error.
  ///
  /// Parameters:
  /// - [fieldName]: The name of the text field to observe.
  /// - [focusNode]: The [FocusNode] to listen to.
  /// - [markTouchedOnBlur]: If `true`, marks the field touched when focus is lost (default: `true`).
  /// - [validateOnBlur]: If `true`, validates and updates the field error on blur. By default,
  ///   it follows the field’s `validateOnUpdate` flag.
  void _observeTextFieldFocus(String fieldName, widgets.FocusNode focusNode) {
    if (textFieldFocusListeners.containsKey(fieldName)) return;

    void listener() {
      if (focusNode.hasFocus) {
        // Optionally, you can handle focus gain here
        // nothing to do here for now
      } else {
        final field = state.textField(fieldName);
        if (field.validateOnUpdate) {
          var updatedField = field.copyWith(touched: true);
          // If the field was touched, validate it when focus is lost
          final error = field.validate(state.fields);
          updatedField = updatedField.updateError(error);
          state.fields[fieldName] = updatedField;
          state = state.copyWith(fields: Map.from(state.fields));
        }
      }
    }

    textFieldFocusListeners[fieldName] = listener;
    focusNode.addListener(listener);
  }

  /// Removes the focus listener for the specified text field.
  /// This is useful when cleaning up resources, such as during `onClose()` in a controller.
  ///
  /// - Parameter [fieldName]: The name of the text field to unbind the focus listener from.
  void removeTextFieldFocusListener(String fieldName) {
    final listener = textFieldFocusListeners.remove(fieldName);
    if (listener != null) {
      final focusNode = state.textField(fieldName).focusNode;
      focusNode.removeListener(listener);
    }
  }
}
