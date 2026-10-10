import 'form_state_notifier.dart';

/// A [FormStateNotifier] for `family` providers.
///
/// Riverpod 3 passes the family argument to the notifier's constructor
/// instead of `build`, so subclasses forward it with `super.arg`:
///
/// ```dart
/// class EditPostForm extends FamilyFormStateNotifier<Post, Error, int> {
///   EditPostForm(super.arg);
///   // fields() and onSubmit() can read `arg`.
/// }
///
/// final editPostProvider = NotifierProvider.autoDispose
///     .family<EditPostForm, BondFormState<Post, Error>, int>(EditPostForm.new);
/// ```
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error] representing the failure cases of form submission.
///   - [Arg] The type of the argument that will be passed to the form.
abstract class FamilyFormStateNotifier<Success, Failure extends Error, Arg>
    extends FormStateNotifier<Success, Failure> {
  /// The argument the family provider created this notifier with.
  final Arg arg;

  /// Creates the notifier for [arg], defaults to not stopping at the first error.
  FamilyFormStateNotifier(this.arg, {super.stopOnFirstError});
}
