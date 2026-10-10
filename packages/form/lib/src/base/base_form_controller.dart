import 'dart:developer';
import 'dart:ui' as widgets;

import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// A base mixin to manage the state and logic of a form.
///
/// This mixin provides foundational methods for managing form state, updating fields,
/// validating the form, and handling form submission. It is intended to be used by
/// form controllers that manage individual or stepper-based forms.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error], representing the failure cases of form submission.
///   - [State] The state type extending [BaseBondFormState] that holds the form's fields and submission status.
@protected
mixin BaseFormController<
  Success,
  Failure extends Error,
  State extends BaseBondFormState<Success, Failure>
> {
  /// Returns the current state of the form.
  State get state;

  /// Sets the new state for the form.
  set state(State newState);

  /// Returns the map of field names to their corresponding `FormFieldState`.
  Map<String, FormFieldState> fields();

  /// A flag indicating if the validation should stop on encountering the first error.
  bool stopOnFirstError = false;

  /// A map to hold listeners for text field changes.
  @internal
  final textFieldListeners = <String, widgets.VoidCallback>{};
  @internal
  final textFieldFocusListeners = <String, widgets.VoidCallback>{};

  /// Updates the field value and status.
  ///
  /// This method updates the value and status of a specific form field.
  ///
  /// - [fieldName] The name of the field to update.
  /// - [value] The new value for the field.
  void updateValue<T extends FormFieldState<G>, G>(String fieldName, G value) {
    var field = state.get<T, G>(fieldName);

    var updatedField = value != null
        ? field.copyWith(value: value)
        : field.copyWithNullable(value: null);

    final error = updatedField.validate(state.fields);

    if (error == null) {
      updatedField = updatedField.updateError(null);
    } else if (updatedField.touched && updatedField.validateOnUpdate) {
      updatedField = updatedField.updateError(error);
    }
    state.fields[fieldName] = updatedField;

    var status = state.status;

    // Downgrade status if it was previously submitted or failed
    if (state.status == BondFormStateStatus.submitted ||
        state.status == BondFormStateStatus.failed) {
      status = error != null
          ? BondFormStateStatus.invalid
          : _allValid(false)
          ? BondFormStateStatus.valid
          : BondFormStateStatus.invalid;
    } else if (error != null) {
      status = BondFormStateStatus.invalid;
    } else if (state.status == BondFormStateStatus.invalid ||
        state.status == BondFormStateStatus.pristine) {
      // Only promote to valid if all fields are now valid
      status = _allValid(false)
          ? BondFormStateStatus.valid
          : BondFormStateStatus.invalid;
    }

    state = state.copyWith(fields: Map.from(state.fields), status: status);
  }

  /// Sets an error message for the specified field and updates the form state to invalid.
  ///
  /// This method directly assigns the provided error message to the specified field and
  /// updates the form's status to `BondFormStateStatus.invalid`.
  ///
  /// - [fieldName] The name of the field to set the error for.
  /// - [error] The error message to set for the field.
  void setError(String fieldName, String? error) {
    final field = state.get(fieldName);
    state.fields[fieldName] = field.updateError(error);
    var status = state.status;
    if (error != null) {
      status = BondFormStateStatus.invalid;
    } else if (state.status == BondFormStateStatus.invalid ||
        state.status == BondFormStateStatus.pristine) {
      // Only promote to valid if all fields are now valid
      status = _allValid(false)
          ? BondFormStateStatus.valid
          : BondFormStateStatus.invalid;
    }
    state = state.copyWith(fields: Map.from(state.fields), status: status);
  }

  /// Updates the error message for the specified field and performs additional validation.
  ///
  /// This method updates the error message for the specified field by appending it to any existing
  /// validation errors. It then updates the form's status to `BondFormStateStatus.invalid`.
  ///
  /// - [fieldName]: The name of the field to update the error for.
  /// - [error]: The new error message to append to any existing validation errors for the field.
  void updateError(String fieldName, String error) {
    final field = state.get(fieldName);
    final validationError = field.validate(state.fields);
    state.fields[fieldName] = field.updateError(
      validationError != null ? '$error\n$validationError' : error,
    );
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: BondFormStateStatus.invalid,
    );
  }

  /// Validates all fields in the form.
  ///
  /// This method marks all fields as "touched" and validates them.
  /// If all fields are valid, the form state is updated to `BondFormStateStatus.valid`;
  /// otherwise, it is updated to `BondFormStateStatus.invalid`.
  void validate() {
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      state.fields[fieldName] = field.copyWith(touched: true);
    }
    if (_allValid(true)) {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.valid,
      );
    } else {
      for (final fieldEntry in state.fields.entries) {
        final field = fieldEntry.value;
        final error = field.validate(state.fields);
        state.fields[fieldEntry.key] = field.updateError(error);
      }
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.invalid,
      );
      final errors = state.fields.values
          .where((element) => element.error != null)
          .map((e) => '*${e.error}*')
          .join('\n');
      log('Form is not on valid state\n$errors');
    }
  }

  /// A private getter to check if all fields in the form are valid.
  ///
  /// Returns `true` if all fields are valid, otherwise `false`.
  bool _allValid(bool forceSetError) {
    var allValid = true;
    for (final fieldEntry in state.fields.entries) {
      final field = fieldEntry.value;
      final error = field.validate(state.fields);
      if (error != null) {
        allValid = false;
        if (field.touched && forceSetError) {
          state.fields[fieldEntry.key] = field.updateError(error);
        }
        if (stopOnFirstError) {
          break;
        }
      } else {
        state.fields[fieldEntry.key] = field.updateError(null);
      }
    }
    return allValid;
  }

  /// Initiates the form submission process.
  ///
  /// This method validates the form and, if valid, triggers the [onSubmit] method.
  Future<void> submit() => _onSubmit();

  /// To be implemented by the subclass, detailing what should happen when a form is submitted.
  ///
  /// Returns the result of a successful submission.
  Future<Success> onSubmit();

  /// Called when the form is successfully submitted. Can be overridden.
  ///
  /// Parameters:
  /// - [result] The result of the successful form submission.
  void onSuccess(Success result) {}

  /// Called when form submission fails. Can be overridden.
  ///
  /// Parameters:
  /// error: The error that occurred during form submission.
  void onFailure(Failure error) {}

  /// Internal method to handle form submission.
  ///
  /// This method sets all fields to "touched", validates all fields,
  /// and then either submits the form or logs errors.
  Future<void> _onSubmit() async {
    for (final fieldName in state.fields.keys) {
      final field = state.get(fieldName);
      state.fields[fieldName] = field.copyWith(touched: true);
    }
    if (_allValid(true)) {
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.submitting,
      );
      try {
        final result = await onSubmit();
        state = state.copyWith(
          status: BondFormStateStatus.submitted,
          success: result,
        );
        Future.microtask(() {
          onSuccess(result);
        });
      } catch (error) {
        if (error is HasValidationErrors) {
          _updateValidationErrors(error.errors);
        }
        if (error is Failure) {
          state = state.copyWith(
            status: BondFormStateStatus.failed,
            failure: error,
          );
          Future.microtask(() {
            onFailure(error);
          });
        } else {
          rethrow;
        }
      }
    } else {
      for (final fieldEntry in state.fields.entries) {
        final field = fieldEntry.value;
        final error = field.validate(state.fields);
        state.fields[fieldEntry.key] = field.updateError(error);
      }
      state = state.copyWith(
        fields: Map.from(state.fields),
        status: BondFormStateStatus.invalid,
      );
      final errors = state.fields.values
          .where((element) => element.error != null)
          .map((e) => '*${e.error}*')
          .join('\n');
      log('Form is not on valid state\n$errors');
    }
  }

  /// Internal method to update validation errors for form fields.
  ///
  /// This method updates the validation errors for each form field based on the provided [errors] map.
  /// It iterates through the fields, retrieves the corresponding error messages from the map,
  /// and updates the error state of each field accordingly.
  ///
  /// - Parameter [errors] A map containing field names as keys and lists of error messages as values.
  void _updateValidationErrors(Map<String, List<String>> errors) {
    for (final fieldEntry in state.fields.entries) {
      final field = fieldEntry.value;
      final error = errors[fieldEntry.key]?.join('\n');
      state.fields[fieldEntry.key] = field.updateError(error);
    }
    state = state.copyWith(
      fields: Map.from(state.fields),
      status: BondFormStateStatus.invalid,
    );
  }

  /// Clears the form state and resets it to its initial pristine state.
  ///
  /// This method resets all form fields to their initial state, clears any success or failure information,
  /// and sets the form status to 'pristine'.
  void clear() {
    state = state.copyWith(
      fields: Map.from(fields()),
      status: BondFormStateStatus.pristine,
      success: null,
      failure: null,
    );
  }
}
