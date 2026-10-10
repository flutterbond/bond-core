import 'dart:io';

import 'package:bond_form/bond_form.dart';

/// Represents the state of a file field in a form.
///
/// This class extends [FormFieldState] to handle file uploads.
/// It includes validation rules and other properties for managing
/// the state of a file field.
class FileFieldState extends FormFieldState<File?> {
  /// Creates a new instance of [FileFieldState].
  ///
  /// - [value] The initial value of the file field.
  /// - [label] The label for the file field.
  /// - [rules] A list of validation rules to apply to the file field.
  FileFieldState(File? value, {required super.label, super.rules = const []})
    : super(value: value);

  @override
  FileFieldState copyWith({
    File? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<File?>>? rules,
  }) {
    return FileFieldState(
      value ?? this.value,
      label: label ?? this.label,
      rules: rules ?? this.rules,
    );
  }

  @override
  FileFieldState copyWithNullable({File? value}) {
    return FileFieldState(value, label: label, rules: rules);
  }

  @override
  FileFieldState updateError(String? error) => copyWith(error: error);
}
