import 'dart:io';

import 'package:bond_form/src/validation/validation_rule.dart';

/// A Validation rule to check if the file size is within a specified limit.
class FileSizeRule extends ValidationRule<File?> {
  /// The maximum size of the file in bytes.
  final int maxSizeInBytes;

  /// Creates a new instance of the [FileSizeRule] validation rule.
  ///
  /// - [maxSizeInBytes] The maximum size of the file in bytes (required).
  /// - [message] A custom validation message (optional) to be displayed when the validation fails.
  FileSizeRule({required this.maxSizeInBytes, String? message})
    : super(message);

  FileSizeRule.megabyte({required int maxSizeInMegabytes, String? message})
    : maxSizeInBytes = maxSizeInMegabytes * 1024 * 1024,
      super(message);

  @override
  String validatorMessage(String fieldName) =>
      l10n.fileSizeValidationMessage(fieldName, maxSizeInBytes);

  @override
  bool validate(File? value, Map<String, dynamic> fields) {
    if (value == null) return false;
    return value.lengthSync() <= maxSizeInBytes;
  }
}
