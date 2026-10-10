import 'package:bond_form/bond_form.dart';

/// A controller to manage a multi-step form.
///
/// The `StepperFormController` handles the state of a form that is divided into multiple steps,
/// allowing for navigating between steps and handling the combined form state.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error] representing the failure cases of form submission.
mixin StepperFormController<Success, Failure extends Error>
    on
        BaseFormController<
          Success,
          Failure,
          StepperFormState<Success, Failure>
        > {
  List<StepFormController> get steps;

  /// Returns the map of field names to their corresponding `FormFieldState`.
  @override
  Map<String, FormFieldState> fields() => state.fields;

  /// Moves to the next step in the form.
  ///
  /// Validates the current step before moving to the next step.
  /// If there are no more steps, it calls the `submit` method.
  void next() {
    if (_isCurrentStepValid) {
      final nextStep = state.currentStep + 1;
      if (nextStep < steps.length) {
        // Move to the next step
        state = state.copyWith(currentStep: nextStep);
      } else {
        // If there are no more steps, submit the form
        submit();
      }
    }
  }

  /// Moves to the previous step in the form.
  void previous() {
    final prevStep = state.currentStep - 1;
    if (prevStep >= 0) {
      state = state.copyWith(currentStep: prevStep);
    }
  }

  /// Checks if the current step is valid.
  bool get _isCurrentStepValid {
    final currentController = steps[state.currentStep];
    currentController.validate();
    return currentController.state.status == BondFormStateStatus.valid;
  }
}
