import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

import '../../mounted_state_guard.dart';

/// A state notifier for managing the state of a single step in a stepper form.
///
/// The [StepFormStateNotifier] class extends [Notifier] to provide state management
/// for a single step in a multi-step form. This class is designed to handle form state,
/// validation, and submission logic for a specific step in a stepper form sequence.
///
/// Declare it with `NotifierProvider` or `NotifierProvider.autoDispose`; for a
/// `family` provider, extend [FamilyStepFormStateNotifier].
///
/// Type Parameters:
/// - [Success] The data type representing the result of a successful form submission.
/// - [Failure] The error type that extends [Error], representing failure cases of form submission.
abstract class StepFormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>>
    with
        MountedStateGuard<BondFormState<Success, Failure>>,
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        StepFormController<Success, Failure> {
  /// Constructor to initialize the [StepFormStateNotifier].
  ///
  /// - [stopOnFirstError]: Optional flag indicating if the validation should stop on encountering the first error.
  StepFormStateNotifier({bool stopOnFirstError = false}) {
    this.stopOnFirstError = stopOnFirstError;
  }

  /// Builds the initial state of the form.
  ///
  /// This method initializes a new [BondFormState] with the fields managed by this form controller.
  ///
  /// Returns:
  /// A new instance of [BondFormState] with the form fields.
  @override
  BondFormState<Success, Failure> build() {
    onDisposeWithState(dispose);
    return trackInitialState(BondFormState<Success, Failure>(fields: fields()));
  }
}

/// The auto-dispose variant of [StepFormStateNotifier] from Riverpod 2.
@Deprecated(
  'Extend StepFormStateNotifier and declare the provider with '
  'NotifierProvider.autoDispose. Riverpod 3 removed AutoDisposeNotifier.',
)
typedef AutoDisposeStepFormStateNotifier<Success, Failure extends Error> =
    StepFormStateNotifier<Success, Failure>;
