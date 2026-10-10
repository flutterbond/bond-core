import 'dart:ui';

import 'package:intl/intl.dart';

import 'l10n/messages_all_locales.dart';

/// A class for handling validation-related localizations.
///
/// This class provides localized validation error messages for various validation rules.
///
/// run this command to generate the validator_messages_all.dart file:
/// dart run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/validator_localizations.dart lib/l10n/validator_messages_*.arb
class ValidatorLocalizations {
  /// Creates a new [ValidatorLocalizations] instance for the specified locale.
  ///
  /// The [localeName] parameter specifies the name of the locale, e.g., 'en_US'.
  ValidatorLocalizations._(this.localeName);

  /// Loads the [ValidatorLocalizations] instance for the given [locale].
  ///
  /// This method initializes the localized messages for the specified locale.
  static Future<ValidatorLocalizations> load(Locale locale) {
    final name = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return ValidatorLocalizations._(localeName);
    });
  }

  final String localeName;

  /// Generates a validation error message for a required field.
  ///
  /// This message indicates that the [fieldName] is required.
  String requiredValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName is required.',
      name: 'requiredValidationMessage',
      desc: 'Validation message for a required field',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for an invalid email field.
  ///
  /// This message indicates that the [fieldName] must be a valid email address.
  String emailValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid email address.',
      name: 'emailValidationMessage',
      desc: 'Validation message for an email field',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field with minimum value.
  ///
  /// This message indicates that the [fieldName] must have a minimum value of [value].
  String minValueValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a minimum value of $value.',
      name: 'minValueValidationMessage',
      desc: 'Validation message for a field with minimum value',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field with maximum value.
  ///
  /// This message indicates that the [fieldName] must have a maximum value of [value].
  String maxValueValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a maximum value of $value.',
      name: 'maxValueValidationMessage',
      desc: 'Validation message for a field with maximum value',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field shorter than the minimum length.
  ///
  /// This message indicates that the [fieldName] must be at least [length] characters long.
  String minLengthValidationMessage(String fieldName, int length) {
    return Intl.message(
      '$fieldName must be at least $length characters long.',
      name: 'minLengthValidationMessage',
      desc: 'Validation message for a field shorter than the minimum length',
      args: [fieldName, length],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field longer than the maximum length.
  ///
  /// This message indicates that the [fieldName] must not exceed [length] characters.
  String maxLengthValidationMessage(String fieldName, int length) {
    return Intl.message(
      '$fieldName must not exceed $length characters.',
      name: 'maxLengthValidationMessage',
      desc: 'Validation message for a field longer than the maximum length',
      args: [fieldName, length],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must be in a list.
  ///
  /// This message indicates that the [fieldName] must be in the given list.
  String inValuesValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be in the given list.',
      name: 'inValuesValidationMessage',
      desc: 'Validation message for a field that must be in a list',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should not be in a list.
  ///
  /// This message indicates that the [fieldName] should not be in the given list.
  String notInValuesValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName should not be in the given list.',
      name: 'notInValuesValidationMessage',
      desc: 'Validation message for a field that should not be in a list',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should be an integer.
  ///
  /// This message indicates that the [fieldName] must be an integer.
  String integerValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be an integer.',
      name: 'integerValidationMessage',
      desc: 'Validation message for a field that should be an integer',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should be numeric.
  ///
  /// This message indicates that the [fieldName] must be numeric.
  String numericValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be numeric.',
      name: 'numericValidationMessage',
      desc: 'Validation message for a field that should be numeric',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should be numeric with a specific length.
  ///
  /// This message indicates that the [fieldName] must be numeric and have a length of exactly [value].
  String digitsValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must be numeric and have a length of exactly $value.',
      name: 'digitsValidationMessage',
      desc: 'Validation message for a field that should be numeric and have a specific length',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should have a length between two values.
  ///
  /// This message indicates that the [fieldName] must have a length between [min] and [max].
  String digitsBetweenValidationMessage(String fieldName, num min, num max) {
    return Intl.message(
      '$fieldName must have a length between $min and $max.',
      name: 'digitsBetweenValidationMessage',
      desc: 'Validation message for a field that should have a length between two values',
      args: [fieldName, min, max],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should have a specific size.
  ///
  /// This message indicates that the [fieldName] must have a size of [value].
  String sizeValidationMessage(String fieldName, int value) {
    return Intl.message(
      '$fieldName must have a size of $value.',
      name: 'sizeValidationMessage',
      desc: 'Validation message for a field that should have a specific size',
      args: [fieldName, value],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should have a size between two values.
  ///
  /// This message indicates that the [fieldName] must have a size between [min] and [max].
  String betweenValidationMessage(String fieldName, num min, num max) {
    return Intl.message(
      '$fieldName must have a size between $min and $max.',
      name: 'betweenValidationMessage',
      desc: 'Validation message for a field that should have a size between two values',
      args: [fieldName, min, max],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should be boolean.
  ///
  /// This message indicates that the [fieldName] must be boolean (true, false, 1, 0, '1', '0').
  String booleanValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be boolean (true, false, 1, 0, \'1\', \'0\').',
      name: 'booleanValidationMessage',
      desc: 'Validation message for a field that should be boolean',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that needs confirmation.
  ///
  /// This message indicates that the confirmation of [fieldName] does not match.
  String confirmedValidationMessage(String fieldName) {
    return Intl.message(
      'Confirmation of $fieldName does not match.',
      name: 'confirmedValidationMessage',
      desc: 'Validation message for a field that needs confirmation',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should be a valid date.
  ///
  /// This message indicates that the [fieldName] must be a valid date.
  String dateValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid date.',
      name: 'dateValidationMessage',
      desc: 'Validation message for a field that should be a date',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should comply with a specific date format.
  ///
  /// This message indicates that the [fieldName] must be in the format [format].
  String dateFormatValidationMessage(String fieldName, String format) {
    return Intl.message(
      '$fieldName must be in the format $format.',
      name: 'dateFormatValidationMessage',
      desc: 'Validation message for a field that should comply with a specific format',
      args: [fieldName, format],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should have a different value from another field.
  ///
  /// This message indicates that the [fieldName] must have a different value from [field].
  String differentValidationMessage(String fieldName, String field) {
    return Intl.message(
      '$fieldName must have a different value from $field.',
      name: 'differentValidationMessage',
      desc: 'Validation message for a field that should be different from another field',
      args: [fieldName, field],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should have the same value as another field.
  ///
  /// This message indicates that the [fieldName] must have the same value as [field].
  String sameValidationMessage(String fieldName, String field) {
    return Intl.message(
      '$fieldName must have the same value as $field.',
      name: 'sameValidationMessage',
      desc: 'Validation message for a field that should have the same value as another field',
      args: [fieldName, field],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that should contain only alphabetic characters.
  ///
  /// This message indicates that the [fieldName] must contain only alphabetic characters.
  String alphaValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must contain only alphabetic characters.',
      name: 'alphaValidationMessage',
      desc: 'Validation message for a field that should contain only alphabetic characters',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that may only contain alphanumeric characters, dashes, and underscores.
  ///
  /// This message indicates that the [fieldName] may only contain alphanumeric characters, dashes, and underscores.
  String alphaDashValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName may only contain alphanumeric characters, dashes, and underscores.',
      name: 'alphaDashValidationMessage',
      desc: 'Validation message for a field that may only contain alphanumeric characters, dashes, and underscores',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must only contain alphanumeric characters.
  ///
  /// This message indicates that the [fieldName] must only contain alphanumeric characters.
  String alphaNumValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must only contain alphanumeric characters.',
      name: 'alphaNumValidationMessage',
      desc: 'Validation message for a field that must only contain alphanumeric characters',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must be a valid URL.
  ///
  /// This message indicates that the [fieldName] must be a valid URL.
  String urlValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid URL.',
      name: 'urlValidationMessage',
      desc: 'Validation message for a field that must be a valid URL',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must match a regex pattern.
  ///
  /// This message indicates that the [fieldName] must match the specified pattern.
  String regexValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must match the specified pattern.',
      name: 'regexValidationMessage',
      desc: 'Validation message for a field that must match a regex pattern',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must have a maximum number of selected values.
  ///
  /// This message indicates that you may only select [max] [fieldName].
  String maxSelectedValidationMessage(String fieldName, int max) {
    return Intl.message(
      'You may only select $max $fieldName.',
      name: 'maxSelectedValidationMessage',
      desc: 'Validation message for a field that must have a maximum number of selected values',
      args: [fieldName, max],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must have a minimum number of selected values.
  ///
  /// This message indicates that you must select at least [min] $fieldName.
  String minSelectedValidationMessage(String fieldName, int min) {
    return Intl.message(
      'You must select at least $min $fieldName.',
      name: 'minSelectedValidationMessage',
      desc: 'Validation message for a field that must have a minimum number of selected values',
      args: [fieldName, min],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must have a range of selected values.
  ///
  /// This message indicates that you must select between [min] and [max] $fieldName.
  String rangeSelectedValidationMessage(String fieldName, int min, int max) {
    return Intl.message(
      'You must select between $min and $max $fieldName.',
      name: 'rangeSelectedValidationMessage',
      desc: 'Validation message for a field that must have a range of selected values',
      args: [fieldName, min, max],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a date field that must be after another date.
  ///
  /// This message indicates that the [fieldName] must be after [after].
  String dateAfterValidationMessage(String fieldName, String after) {
    return Intl.message(
      '$fieldName must be after $after.',
      name: 'dateAfterValidationMessage',
      desc:
          'Validation message for a date field that must be after another date',
      args: [fieldName, after],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a date field that must be before another date.
  ///
  /// This message indicates that the [fieldName] must be before [before].
  String dateBeforeValidationMessage(String fieldName, String before) {
    return Intl.message(
      '$fieldName must be before $before.',
      name: 'dateBeforeValidationMessage',
      desc: 'Validation message for a date field that must be before another date',
      args: [fieldName, before],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must be checked.
  ///
  /// This message indicates that the field [fieldName] must be checked.
  String isTrueValidationMessage(String fieldName) {
    return Intl.message(
      'The field $fieldName must be checked.',
      name: 'isTrueValidationMessage',
      desc: 'Validation message for a field that must be checked',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must be unchecked.
  ///
  /// This message indicates that the field [fieldName] must be unchecked.
  String isFalseValidationMessage(String fieldName) {
    return Intl.message(
      'The field $fieldName must be unchecked.',
      name: 'isFalseValidationMessage',
      desc: 'Validation message for a field that must be unchecked',
      args: [fieldName],
      locale: localeName,
    );
  }

  /// Generates a validation error message for a field that must be a valid phone number.
  /// This message indicates that the field [fieldName] must be a valid phone number.
  String phoneNumberValidationMessage(String fieldName) {
    return Intl.message(
      '$fieldName must be a valid phone number.',
      name: 'phoneNumberValidationMessage',
      desc: 'Validation message for a field that must be a valid phone number',
      args: [fieldName],
      locale: localeName,
    );
  }

  String fileSizeValidationMessage(String fieldName, int size) {
    return Intl.message(
      '$fieldName must be less than $size KB.',
      name: 'fileSizeValidationMessage',
      desc: 'Validation message for a field that must be less than a specific size',
      args: [fieldName, size],
      locale: localeName,
    );
  }

  String fileTypeValidationMessage(String fieldName, String type) {
    return Intl.message(
      '$fieldName must be of type: $type.',
      name: 'fileTypeValidationMessage',
      desc:
          'Validation message for a file field that must be of a specific type',
      args: [fieldName, type],
      locale: localeName,
    );
  }
}
