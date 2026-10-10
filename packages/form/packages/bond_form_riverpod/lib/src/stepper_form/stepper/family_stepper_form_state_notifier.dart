import 'stepper_form_state_notifier.dart';

/// A [StepperFormStateNotifier] for `family` providers.
///
/// Riverpod 3 passes the family argument to the notifier's constructor
/// instead of `build`, so subclasses forward it with `super.arg` and declare
/// the provider with `NotifierProvider.family` (or `.autoDispose.family`).
///
/// Type Parameters:
/// - [Success] The type representing a successful result of the form submission.
/// - [Failure] The type representing the failure case, which extends [Error].
/// - [Arg] The argument type passed to the family provider.
abstract class FamilyStepperFormStateNotifier<
  Success,
  Failure extends Error,
  Arg
>
    extends StepperFormStateNotifier<Success, Failure> {
  /// The argument the family provider created this notifier with.
  final Arg arg;

  /// Constructor to initialize [FamilyStepperFormStateNotifier] for [arg].
  ///
  /// - [stopOnFirstError] Whether validation should stop on the first encountered error.
  FamilyStepperFormStateNotifier(this.arg, {super.stopOnFirstError});
}
