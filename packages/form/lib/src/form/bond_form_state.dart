import 'package:bond_form/bond_form.dart';

/// Represents the state of a form with its fields and submission status.
class BondFormState<Success, Failure extends Error>
    extends BaseBondFormState<Success, Failure> {
  /// Creates a [BondFormState] with the provided parameters.
  ///
  /// - [fields] A map of field names to their corresponding field state objects.
  /// - [status] The current status of the form (default is [BondFormStateStatus.pristine]).
  /// - [success] The success result of the form submission.
  /// - [failure] The failure result of the form submission.
  BondFormState({
    required super.fields,
    super.status,
    super.success,
    super.failure,
  });

  /// Creates a copy of this [BondFormState] with optional parameter overrides.
  @override
  State copyWith<State extends BaseBondFormState<Success, Failure>>({
    Map<String, FormFieldState>? fields,
    BondFormStateStatus? status,
    Success? success,
    Failure? failure,
  }) {
    return BondFormState<Success, Failure>(
      fields: fields ?? this.fields,
      status: status ?? this.status,
      success: success ?? successResult,
      failure: failure ?? failureResult,
    ) as State; // Cast the result to the expected generic type
  }
}
