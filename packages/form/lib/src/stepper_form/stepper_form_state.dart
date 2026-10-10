import 'package:bond_form/bond_form.dart';

/// A state class representing a form with multiple steps.
///
/// The `StepperFormState` class extends [BaseBondFormState] to manage the state
/// of a form divided into multiple steps. It provides functionality to handle
/// and combine the state of individual form steps into a single state representation.
///
/// Type Parameters:
///   - [Success]: The data type representing a successful form submission result.
///   - [Failure]: The error type that extends [Error] representing the failure cases of form submission.
class StepperFormState<Success, Failure extends Error>
    extends BaseBondFormState<Success, Failure> {
  /// The current step in the form stepper.
  final int currentStep;

  /// Creates a new [StepperFormState] from a list of individual step controllers.
  ///
  /// This factory constructor initializes a [StepperFormState] with the given [parent] controller
  /// and a list of [steps], combining the form fields and statuses from each step into a single state.
  ///
  /// The [parent] controller is assigned to each step, ensuring proper coordination between
  /// the step controllers and the parent stepper controller.
  ///
  /// Parameters:
  /// - [parent]: The [StepperFormController] that manages the entire multi-step form process.
  /// - [steps]: A list of [StepFormController] instances representing the individual steps in the form.
  ///
  /// Returns:
  /// A new instance of [StepperFormState] with all combined fields, statuses, and an initial step index of 0.
  ///
  /// The returned state has:
  /// - [currentStep] Set to 0, indicating the starting step of the form.
  /// - [fields] Combined form fields from all the steps.
  /// - [status] The combined status derived from all the step states.
  /// - [success] Set to `null` initially (to be determined by the form submission).
  /// - [failure] Set to `null` initially (to be determined by the form submission).
  factory StepperFormState.fromSteps({
    required StepperFormController parent,
    required List<StepFormController> steps,
  }) {
    final states = steps.map((item) => item.state).toList();
    for (final step in steps) {
      step.parent = parent;
    }
    final fields = _combineFields(states);
    final status = _deriveCombinedStatus(states);
    return StepperFormState<Success, Failure>(
      currentStep: 0,
      fields: fields,
      status: status,
      success: null,
      failure: null,
    );
  }

  /// Creates an instance of [StepperFormState] with specific field values.
  ///
  /// This constructor allows you to manually specify the current step, field states,
  /// and other optional parameters like status, success, and failure results.
  ///
  /// - [currentStep] The current step number in the stepper form.
  /// - [fields] A map of field names to their corresponding state objects.
  /// - [status] The current status of the form (default is [BondFormStateStatus.pristine]).
  /// - [success] The success result of the form submission.
  /// - [failure] The failure result of the form submission.
  StepperFormState({
    required this.currentStep,
    required super.fields,
    super.status,
    super.success,
    super.failure,
  });

  /// Combines the fields from all step states into a single map.
  ///
  /// This method merges all field states from each step into a single unified map.
  ///
  /// - [stepStates] A list of [BondFormState] representing the state of each step.
  /// - Returns: A combined map of all field states.
  static Map<String, FormFieldState> _combineFields<
    Success,
    Failure extends Error
  >(List<BondFormState<Success, Failure>> stepStates) {
    final combinedFields = <String, FormFieldState>{};
    for (final stepState in stepStates) {
      combinedFields.addAll(stepState.fields);
    }
    return combinedFields;
  }

  /// Derives the combined status of all step states.
  ///
  /// This method determines the overall status of the stepper form by evaluating
  /// the status of each step. It returns the most relevant status based on the
  /// priorities of different states (e.g., submitting, failed, valid, etc.).
  ///
  /// - [stepStates] A list of [BondFormState] representing the state of each step.
  /// - Returns: The combined [BondFormStateStatus] for the entire form.
  static BondFormStateStatus _deriveCombinedStatus<
    Success,
    Failure extends Error
  >(List<BondFormState<Success, Failure>> stepStates) {
    // If any step is submitting, the combined state is submitting.
    if (stepStates.any(
      (state) => state.status == BondFormStateStatus.submitting,
    )) {
      return BondFormStateStatus.submitting;
    }

    // If all steps are valid, the combined state is valid.
    if (stepStates.every(
      (state) => state.status == BondFormStateStatus.valid,
    )) {
      return BondFormStateStatus.valid;
    }

    // If any step has failed, the combined state is failed.
    if (stepStates.any((state) => state.status == BondFormStateStatus.failed)) {
      return BondFormStateStatus.failed;
    }

    // If any step has validation errors, the combined state is invalid.
    if (stepStates.any(
      (state) => state.status == BondFormStateStatus.invalid,
    )) {
      return BondFormStateStatus.invalid;
    }

    // If all steps are pristine (untouched), the combined state is pristine.
    if (stepStates.every(
      (state) => state.status == BondFormStateStatus.pristine,
    )) {
      return BondFormStateStatus.pristine;
    }

    // Default to pristine if none of the above conditions match.
    return BondFormStateStatus.pristine;
  }

  /// Creates a copy of this [StepperFormState] with optional parameter overrides.
  ///
  /// This method allows creating a new instance of [StepperFormState] with modified
  /// fields, status, success, failure, or current step.
  ///
  /// - [fields] A map of field names to their corresponding state objects to override.
  /// - [status] The current status of the form to override.
  /// - [success] The success result of the form submission to override.
  /// - [failure] The failure result of the form submission to override.
  /// - [currentStep] The step number to override.
  /// - Returns: A new instance of [StepperFormState] with the provided overrides.
  @override
  State copyWith<State extends BaseBondFormState<Success, Failure>>({
    Map<String, FormFieldState>? fields,
    BondFormStateStatus? status,
    Success? success,
    Failure? failure,
    int? currentStep,
  }) {
    return StepperFormState<Success, Failure>(
      fields: fields ?? this.fields,
      status: status ?? this.status,
      success: success ?? successResult,
      failure: failure ?? failureResult,
      currentStep: currentStep ?? this.currentStep,
    ) as State; // Cast the result to the expected generic type.
  }
}
