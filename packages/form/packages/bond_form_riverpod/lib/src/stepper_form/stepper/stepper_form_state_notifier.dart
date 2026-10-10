import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

import '../../mounted_state_guard.dart';

/// A state notifier for managing a multi-step form using Riverpod.
///
/// This class extends [Notifier] to handle the state management of a form
/// that is divided into multiple steps. Declare it with `NotifierProvider`, or
/// with `NotifierProvider.autoDispose` to dispose of the state once it is no
/// longer listened to. For a `family` provider, extend
/// [FamilyStepperFormStateNotifier].
///
/// Type Parameters:
/// - [Success] The type representing a successful result of the form submission.
/// - [Failure] The type representing the failure case, which extends [Error].
abstract class StepperFormStateNotifier<Success, Failure extends Error>
    extends Notifier<StepperFormState<Success, Failure>>
    with
        MountedStateGuard<StepperFormState<Success, Failure>>,
        BaseFormController<
          Success,
          Failure,
          StepperFormState<Success, Failure>
        >,
        StepperFormController<Success, Failure> {
  /// Constructor to initialize [StepperFormStateNotifier].
  ///
  /// - [stopOnFirstError] Whether validation should stop on the first encountered error.
  StepperFormStateNotifier({bool stopOnFirstError = false}) {
    this.stopOnFirstError = stopOnFirstError;
  }

  /// Builds the initial [StepperFormState] for the notifier.
  ///
  /// Constructs the initial form state by combining states from individual step controllers.
  @override
  StepperFormState<Success, Failure> build() => trackInitialState(
    StepperFormState<Success, Failure>.fromSteps(parent: this, steps: steps),
  );

  /// To be implemented by subclasses, specifying the behavior when the form is submitted.
  ///
  /// This method should define what happens upon form submission, such as API calls,
  /// data persistence, or any other necessary logic.
  @override
  Future<Success> onSubmit();
}

/// The auto-dispose variant of [StepperFormStateNotifier] from Riverpod 2.
@Deprecated(
  'Extend StepperFormStateNotifier and declare the provider with '
  'NotifierProvider.autoDispose. Riverpod 3 removed AutoDisposeNotifier.',
)
typedef AutoDisposeStepperFormStateNotifier<Success, Failure extends Error> =
    StepperFormStateNotifier<Success, Failure>;
