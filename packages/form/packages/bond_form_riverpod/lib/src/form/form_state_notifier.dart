import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:riverpod/riverpod.dart';

import '../mounted_state_guard.dart';

/// A class to manage form state, extending a notifier to notify its subscribers
/// of changes, and using the FormController mixin for form operations.
///
/// Riverpod 3 has a single [Notifier] class, so the provider decides whether
/// the form is kept alive or disposed once nothing listens to it:
///
/// ```dart
/// final loginProvider = NotifierProvider.autoDispose<LoginFormController,
///     BondFormState<String, Error>>(LoginFormController.new);
/// ```
///
/// For a `family` provider, extend [FamilyFormStateNotifier], which receives
/// the argument through its constructor.
///
/// The fields are disposed when the provider is disposed or rebuilt. Once the
/// provider is disposed, [state] keeps returning the last state and writes
/// are ignored, so an [onSubmit] that completes late does not throw.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error] representing the failure cases of form submission.
abstract class FormStateNotifier<Success, Failure extends Error>
    extends Notifier<BondFormState<Success, Failure>>
    with
        MountedStateGuard<BondFormState<Success, Failure>>,
        BaseFormController<Success, Failure, BondFormState<Success, Failure>>,
        FieldChangeTrackingMixin<Success, Failure>,
        FormController<Success, Failure> {
  /// Constructor for FormStateNotifier, defaults to not stopping at the first error.
  FormStateNotifier({bool stopOnFirstError = false}) {
    this.stopOnFirstError = stopOnFirstError;
  }

  /// Builds the initial state for the form.
  @override
  BondFormState<Success, Failure> build() {
    onDisposeWithState(dispose);
    return trackInitialState(BondFormState<Success, Failure>(fields: fields()));
  }

  /// An abstract method to be implemented by the subclass,
  /// detailing what should happen when the form is submitted.
  @override
  Future<Success> onSubmit();
}

/// The auto-dispose variant of [FormStateNotifier] from Riverpod 2.
@Deprecated(
  'Extend FormStateNotifier and declare the provider with '
  'NotifierProvider.autoDispose. Riverpod 3 removed AutoDisposeNotifier.',
)
typedef AutoDisposeFormStateNotifier<Success, Failure extends Error> =
    FormStateNotifier<Success, Failure>;
