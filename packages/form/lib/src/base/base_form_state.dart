import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// Represents the base state of a form, encapsulating its fields and submission status.
///
/// This abstract class provides a structure to manage form states, including
/// the mapping of field names to their corresponding states, and the overall
/// submission status of the form.
///
/// Type Parameters:
///   - [Success] The data type that represents the result of a successful form submission.
///   - [Failure] The error type that extends [Error], representing the failure cases of form submission.
@protected
abstract class BaseBondFormState<Success, Failure extends Error> {
  /// A map of field names to their corresponding state objects.
  final Map<String, FormFieldState> fields;

  /// The current status of the form.
  final BondFormStateStatus status;

  /// Stores the success result of the form submission.
  @protected
  final Success? successResult;

  /// Stores the failure result of the form submission.
  @protected
  final Failure? failureResult;

  /// Creates an instance of [BaseBondFormState] with the provided parameters.
  ///
  /// - [fields]: A map of field names to their corresponding field state objects.
  /// - [status]: The current status of the form. Defaults to [BondFormStateStatus.pristine].
  /// - [success]: The success result of the form submission.
  /// - [failure]: The failure result of the form submission.
  BaseBondFormState({
    required this.fields,
    this.status = BondFormStateStatus.pristine,
    Success? success,
    Failure? failure,
  }) : successResult = success,
       failureResult = failure;

  /// Retrieves the success result of the form submission.
  ///
  /// Throws a [StateError] if the form is not in the [BondFormStateStatus.submitted] state.
  Success get success {
    if (successResult == null || status != BondFormStateStatus.submitted) {
      throw StateError(
        'Accessing success while form not successfully submitted',
      );
    }
    return successResult!;
  }

  /// Retrieves the failure result of the form submission.
  ///
  /// Throws a [StateError] if the form is not in the [BondFormStateStatus.failed] state.
  Failure get failure {
    if (failureResult == null || status != BondFormStateStatus.failed) {
      throw StateError('Accessing failure while form not in failure state');
    }
    return failureResult!;
  }

  /// Retrieves the state of a form field by its [fieldName].
  ///
  /// Throws an [ArgumentError] if no field with the specified [fieldName] is found.
  /// Provides a detailed error message in case of type mismatch, including a debugging tip.
  T get<T extends FormFieldState<G>, G>(String fieldName) {
    if (!fields.containsKey(fieldName)) {
      throw ArgumentError('No field found with name $fieldName');
    }
    final field = fields[fieldName];
    if (field is T) {
      return field;
    } else {
      throw ArgumentError(
        'Type mismatch for field "$fieldName".\n\n'
        'Expected: $T\n\n'
        'Actual: ${field.runtimeType}\n\n'
        'Debugging Tip:\n\n'
        'If you have declared the field as ${field.runtimeType}, make sure to specify the generic type.\n\n'
        'For example, if the actual type is "RadioGroupFieldState<dynamic>", you might need to change it to '
        '"RadioGroupFieldState<bool>" in the field definition.\n\n',
      );
    }
  }

  /// Retrieves the label for a form field by its [fieldName].
  ///
  /// - [fieldName] The name of the field whose label is to be retrieved.
  /// - Returns: The label of the specified form field.
  String label<T extends FormFieldState<G>, G>(String fieldName) =>
      get<T, G>(fieldName).label;

  /// Retrieves the error message for a form field by its [fieldName].
  ///
  /// - [fieldName] The name of the field whose error message is to be retrieved.
  /// - Returns: The error message of the specified form field, or `null` if no error exists.
  String? error<T extends FormFieldState<G>, G>(String fieldName) =>
      get<T, G>(fieldName).error;

  /// Allows accessing the state of a form field using the subscript operator.
  ///
  /// - [fieldName] The name of the field to retrieve.
  /// - Returns: The state of the specified form field.
  FormFieldState operator [](String fieldName) => get(fieldName);

  /// Checks the validity of a form field by its [fieldName].
  ///
  /// - [fieldName] The name of the field to validate.
  /// - Returns: `true` if the field is valid, `false` otherwise.
  bool valid<T extends FormFieldState<G>, G>(String fieldName) =>
      get<T, G>(fieldName).validate(fields) == null;

  /// Creates a copy of this [BaseBondFormState] with optional parameter overrides.
  ///
  /// Allows creating a new instance of the form state while overriding specific fields, status, success, or failure.
  ///
  /// - [fields] The map of field names to their corresponding state objects to override.
  /// - [status] The current status of the form to override.
  /// - [success] The success result of the form submission to override.
  /// - [failure] The failure result of the form submission to override.
  ///
  /// - Returns: A new instance of [BaseBondFormState] with the provided overrides.
  State copyWith<State extends BaseBondFormState<Success, Failure>>({
    Map<String, FormFieldState>? fields,
    BondFormStateStatus? status,
    Success? success,
    Failure? failure,
  });
}
