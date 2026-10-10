import 'package:bond_form/bond_form.dart';
import 'package:get/get.dart';

/// A Bond-compatible form controller wrapped around a GetxController instance.
///
/// This abstract class extends `GetxController` and mixes in `BaseFormController`
/// and `FormController` to manage the form state using Getx's reactive state management.
///
/// Type Parameters:
/// - `Success`: The type representing a successful form submission.
/// - `Failure`: The type representing a failed form submission, which must extend `Error`.
abstract class GetxFormController<Success, Failure extends Error>
    extends GetxController
    with
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        FieldChangeTrackingMixin<Success, Failure>,
        FormController<Success, Failure> {
  /// The GetxController instance that manages the form state.
  ///
  /// This is a reactive variable that holds the current state of the form.
  final Rx<BondFormState<Success, Failure>> formState =
      Rx<BondFormState<Success, Failure>>(
        BondFormState<Success, Failure>(fields: {}),
      );

  /// Gets the current state of the form.
  @override
  BondFormState<Success, Failure> get state => formState.value;

  /// Sets a new state for the form.
  ///
  /// This updates the reactive `formState` variable with the new state.
  @override
  set state(BondFormState<Success, Failure> newState) {
    formState.value = newState;
  }

  /// Initializes the form controller.
  ///
  /// This method is called when the controller is initialized. It sets the initial
  /// state of the form with the provided fields.
  @override
  void onInit() {
    super.onInit();
    // Initialize the form state with the provided fields
    formState.value = BondFormState<Success, Failure>(fields: fields());
    initializeFieldTracking();
  }

  /// Updates the value of a specific field in the form.
  ///
  /// This method updates the value of a field identified by [fieldName] with the provided [value].
  /// It uses the generic type parameters [T] for the field state and [G] for the value type.
  /// This method also triggers a reactive update for the field in the form state.
  ///
  /// - [fieldName]: The name of the field to update.
  /// - [value]: The new value to set for the field.
  /// - [T]: The type of the field state, which extends `FormFieldState<G>`.
  /// - [G]: The type of the value being set for the field.
  ///
  /// Throws an [ArgumentError] if no field with the specified [fieldName] and [G] Tpe is found.
  @override
  void updateValue<T extends FormFieldState<G>, G>(String fieldName, G value) {
    super.updateValue<T, G>(fieldName, value);

    update([fieldName]);
  }

  /// Disposes the controller and cleans up resources.
  ///
  /// This method is called when the controller is removed from memory.
  @override
  void onClose() {
    dispose();
    super.onClose();
  }
}
