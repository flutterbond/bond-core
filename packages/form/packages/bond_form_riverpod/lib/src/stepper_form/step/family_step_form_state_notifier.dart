import 'step_form_state_notifier.dart';

/// A [StepFormStateNotifier] for `family` providers.
///
/// Riverpod 3 passes the family argument to the notifier's constructor
/// instead of `build`, so subclasses forward it with `super.arg` and declare
/// the provider with `NotifierProvider.family` (or `.autoDispose.family`).
///
/// Type Parameters:
/// - [Success] The data type representing the result of a successful form submission.
/// - [Failure] The error type that extends [Error], representing failure cases of form submission.
/// - [Arg] The type of the argument that will be passed to the family notifier.
abstract class FamilyStepFormStateNotifier<Success, Failure extends Error, Arg>
    extends StepFormStateNotifier<Success, Failure> {
  /// The argument the family provider created this notifier with.
  final Arg arg;

  /// Constructor to initialize the [FamilyStepFormStateNotifier] for [arg].
  ///
  /// - [stopOnFirstError]: Optional flag indicating if the validation should stop on encountering the first error.
  FamilyStepFormStateNotifier(this.arg, {super.stopOnFirstError});
}
