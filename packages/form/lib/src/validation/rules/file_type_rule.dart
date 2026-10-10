import 'dart:io';

import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:mime/mime.dart';

/// A Validation rule to check if the file is of a specified type.
///
/// This rule validates that the input file is of a specified type.
class FileTypeRule extends ValidationRule<File?> {
  /// The list of allowed mime types to check against.
  final List<String> allowedMimeTypes;

  /// Creates a new instance of the [FileTypeRule] validation rule.
  ///
  /// - [allowedMimeTypes] The list of allowed mime types (required).
  /// - [message] A custom validation message (optional) to be displayed when the validation fails.
  FileTypeRule({required this.allowedMimeTypes, String? message})
    : super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.fileTypeValidationMessage(fieldName, allowedMimeTypes.join(', '));

  @override
  bool validate(File? value, Map<String, FormFieldState> fields) {
    if (value == null) return false;
    final mimeType = lookupMimeType(value.path);
    return allowedMimeTypes.contains(mimeType);
  }
}
