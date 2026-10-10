library;

import 'dart:io';

import 'package:bond_form/bond_form.dart';

export 'rules/alpha.dart';
export 'rules/alpha_dash.dart';
export 'rules/alpha_num.dart';
export 'rules/between.dart';
export 'rules/between_value.dart';
export 'rules/boolean.dart';
export 'rules/date.dart';
export 'rules/date_after.dart';
export 'rules/date_before.dart';
export 'rules/different.dart';
export 'rules/digits.dart';
export 'rules/digits_between.dart';
export 'rules/email.dart';
export 'rules/file_size_rule.dart';
export 'rules/file_type_rule.dart';
export 'rules/in_list.dart';
export 'rules/integer.dart';
export 'rules/is_false.dart';
export 'rules/is_true.dart';
export 'rules/max_length.dart';
export 'rules/max_selected.dart';
export 'rules/max_value.dart';
export 'rules/min_length.dart';
export 'rules/min_selected.dart';
export 'rules/min_value.dart';
export 'rules/not_in_list.dart';
export 'rules/numeric.dart';
export 'rules/optional.dart';
export 'rules/phone_number.dart';
export 'rules/range_selected.dart';
export 'rules/regex.dart';
export 'rules/required.dart';
export 'rules/required_if.dart';
export 'rules/same.dart';
export 'rules/size.dart';
export 'rules/url.dart';
export 'validation_rule.dart';

/// A utility class that provides convenient methods to create instances of
/// various validation rules.
class Rules {
  /// Creates a [Required] validation rule.
  ///
  /// This rule checks if a value is required and can optionally include a custom
  /// validation message.
  static ValidationRule<T> required<T>({String? message}) =>
      Required<T>(message: message);

  /// Creates a [RequiredIf] validation rule.
  ///
  /// This rule checks if a value is required based on a condition where the value
  /// of another field is equal to [equalTo]. It can include a custom validation message.
  static ValidationRule<T> requiredIf<T>(
    String? otherFieldName, {
    dynamic equalTo,
    String? message,
  }) => RequiredIf<T>(otherFieldName, equalTo: equalTo, message: message);

  /// Creates a [RequiredIf] validation rule based on a condition.
  ///
  /// This rule checks if a value is required based on a provided condition function.
  /// It can include a custom validation message.
  static ValidationRule<T> requiredIfCondition<T>(
    bool Function()? condition, {
    String? message,
  }) => RequiredIf.condition(condition, message: message);

  /// Creates a [Different] validation rule.
  ///
  /// This rule checks if a value is different from another field's value.
  /// It can include a custom validation message.
  static ValidationRule<T> different<T>(String otherField, {String? message}) =>
      Different<T>(otherField, message: message);

  /// Creates an [Alpha] validation rule.
  ///
  /// This rule checks if a string contains only alphabetic characters.
  /// It can include a custom validation message.
  static ValidationRule<String> alpha({String? message}) =>
      Alpha(message: message);

  /// Creates an [AlphaDash] validation rule.
  ///
  /// This rule checks if a string contains only alphabetic, dash, or underscore characters.
  /// It can include a custom validation message.
  static ValidationRule<String?> alphaDash({String? message}) =>
      AlphaDash(message: message);

  /// Creates an [AlphaNum] validation rule.
  ///
  /// This rule checks if a string contains only alphanumeric characters.
  /// It can include a custom validation message.
  static ValidationRule<String?> alphaNum({String? message}) =>
      AlphaNum(message: message);

  /// Creates a [Between] validation rule.
  ///
  /// This rule checks if a string's length is between [min] and [max] (inclusive).
  /// It can include a custom validation message.
  static ValidationRule<String> between({
    required num min,
    required num max,
    String? message,
  }) => Between(min, max, message: message);

  /// Create a [BetweenValue] validation rule.
  ///
  /// This rule checks if a numeric value is between [min] and [max] (inclusive).
  /// /// It can include a custom validation message.
  static ValidationRule<String> betweenValue({
    required num min,
    required num max,
    String? message,
  }) => BetweenValue(min, max, message: message);

  /// Creates a [Boolean] validation rule.
  ///
  /// This rule checks if a string represents a boolean value ("true" or "false").
  /// It can include a custom validation message.
  static ValidationRule<String> boolean({String? message}) =>
      Boolean(message: message);

  /// Creates a [Date] validation rule.
  ///
  /// This rule checks if a string can be parsed as a valid date.
  /// It can include a custom validation message.
  static ValidationRule<String> date({String? message}) =>
      Date(message: message);

  /// Creates a [Digits] validation rule.
  ///
  /// This rule checks if a string contains exactly [digitLength] digits.
  /// It can include a custom validation message.
  static ValidationRule<String> digits({
    required int digitLength,
    String? message,
  }) => Digits(digitLength, message: message);

  /// Creates a [DigitsBetween] validation rule.
  ///
  /// This rule checks if a string contains between [min] and [max] digits (inclusive).
  /// It can include a custom validation message.
  static ValidationRule<String> digitsBetween({
    required num min,
    required num max,
    String? message,
  }) => DigitsBetween(min, max, message: message);

  /// Creates an [Email] validation rule.
  ///
  /// This rule checks if a string is a valid email address.
  /// It can include a custom validation message.
  static ValidationRule<String> email({String? message}) =>
      Email(message: message);

  /// Creates a [PhoneNumber] validation rule.
  /// This rule checks if a string is a valid phone number.
  /// It can include a custom validation message.
  static ValidationRule<String> phoneNumber({String? message}) =>
      PhoneNumber(message: message);

  /// Creates an [InList] validation rule.
  ///
  /// This rule checks if a value is in the list of [validValues].
  /// It can include a custom validation message.
  static ValidationRule<T> inList<T>(List<T> validValues, {String? message}) =>
      InList(validValues, message: message);

  /// Creates an [Integer] validation rule.
  ///
  /// This rule checks if a string can be parsed as an integer.
  /// It can include a custom validation message.
  static ValidationRule<String> integer({String? message}) =>
      Integer(message: message);

  /// Creates a [MaxLength] validation rule.
  ///
  /// This rule checks if a string's length is less than or equal to [max].
  /// It can include a custom validation message.
  static ValidationRule<String> maxLength(int max, {String? message}) =>
      MaxLength(max, message: message);

  /// Creates a [MaxValue] validation rule.
  ///
  /// This rule checks if a numeric value is less than or equal to [max].
  /// It can include a custom validation message.
  static ValidationRule<String> maxValue(int max, {String? message}) =>
      MaxValue(max, message: message);

  /// Creates a [MinLength] validation rule.
  ///
  /// This rule checks if a string's length is greater than or equal to [min].
  /// It can include a custom validation message.
  static ValidationRule<String> minLength(int min, {String? message}) =>
      MinLength(min, message: message);

  /// Creates a [MinValue] validation rule.
  ///
  /// This rule checks if a numeric value is greater than or equal to [min].
  /// It can include a custom validation message.
  static ValidationRule<String> minValue(int min, {String? message}) =>
      MinValue(min, message: message);

  /// Creates a [NotInList] validation rule.
  ///
  /// This rule checks if a value is not in the list of [invalidValues].
  /// It can include a custom validation message.
  static ValidationRule<T> notInList<T>(
    List<T> invalidValues, {
    String? message,
  }) => NotInList(invalidValues, message: message);

  /// Creates a [Numeric] validation rule.
  ///
  /// This rule checks if a string can be parsed as a numeric value.
  /// It can include a custom validation message.
  static ValidationRule<String?> numeric({String? message}) =>
      Numeric(message: message);

  /// Creates a [Regex] validation rule.
  ///
  /// This rule checks if a string matches the specified [regex].
  /// It can include a custom validation message.
  static ValidationRule<String> regex(RegExp regex, {String? message}) =>
      Regex(regex, message: message);

  /// Creates a [Same] validation rule.
  ///
  /// This rule checks if a value is the same as another field's value.
  /// It can include a custom validation message.
  static ValidationRule<T> same<T>({
    required String otherField,
    String? message,
  }) => Same(otherField, message: message);

  /// Creates a [Size] validation rule.
  ///
  /// This rule checks if a string's length is equal to [size].
  /// It can include a custom validation message.
  static ValidationRule<String> size(int size, {String? message}) =>
      Size(size, message: message);

  /// Creates a [Url] validation rule.
  ///
  /// This rule checks if a string is a valid URL.
  /// It can include a custom validation message.
  static ValidationRule<String> url({String? message}) => Url(message: message);

  /// Creates a [MinSelected] validation rule.
  ///
  /// This rule checks if the number of selected items in an iterable is greater
  /// than or equal to [min].
  /// It can include a custom validation message.
  static ValidationRule<T> minSelected<T extends Iterable<G>, G>(
    int min, {
    String? message,
  }) => MinSelected<T, G>(min, message: message);

  /// Creates a [MaxSelected] validation rule.
  ///
  /// This rule checks if the number of selected items in an iterable is less
  /// than or equal to [max].
  /// It can include a custom validation message.
  static ValidationRule<T> maxSelected<T extends Iterable<G>, G>(
    int min, {
    String? message,
  }) => MaxSelected<T, G>(min, message: message);

  /// Creates a [RangeSelected] validation rule.
  ///
  /// This rule checks if the number of selected items in an iterable is within
  /// the range of [min] to [max] (inclusive).
  /// It can include a custom validation message.
  static ValidationRule<Iterable<T>?> rangeSelected<T>({
    required int min,
    required int max,
    String? message,
  }) => RangeSelected<T>(min, max, message: message);

  /// Creates a [DateBefore] validation rule.
  ///
  /// This rule checks if a date is before a specified [date].
  /// It can include a custom validation message.
  static ValidationRule<DateTime> dateBefore(
    DateTime date, {
    String? message,
  }) => DateBefore(date, message: message);

  /// Creates a [DateAfter] validation rule.
  ///
  /// This rule checks if a date is after a specified [date].
  /// It can include a custom validation message.
  static ValidationRule<DateTime> dateAfter(DateTime date, {String? message}) =>
      DateAfter(date, message: message);

  /// Creates a [DateBefore] validation rule from a string date representation.
  ///
  /// This rule checks if a date is before a specified date represented as a string.
  /// It can include a custom validation message.
  static ValidationRule<DateTime?> dateBeforeFromString(
    String date, {
    String? format,
    String? message,
  }) => DateBefore.fromString(date, format: format, message: message);

  /// Creates a [DateAfter] validation rule from a string date representation.
  ///
  /// This rule checks if a date is after a specified date represented as a string.
  /// It can include a custom validation message.
  static ValidationRule<DateTime?> dateAfterFromString(
    String date, {
    String? format,
    String? message,
  }) => DateAfter.fromString(date, format: format, message: message);

  /// Creates an [IsTrue] validation rule.
  ///
  /// This rule checks if a boolean value is true.
  /// support bool, String, and num types.
  /// It can include a custom validation message.
  static ValidationRule<T> isTrue<T>({String? message}) =>
      IsTrue<T>(message: message);

  /// Creates an [IsFalse] validation rule.
  ///
  /// This rule checks if a boolean value is false.
  /// support bool, String, and num types.
  /// It can include a custom validation message.
  static ValidationRule<T> isFalse<T>({String? message}) =>
      IsFalse<T>(message: message);

  /// Creates a [FileTypeRule] validation rule.
  ///
  /// This rule validates that the input file is of a specified type.
  /// It can include a custom validation message.
  static ValidationRule<File?> fileType(
    List<String> allowedMimeTypes, {
    String? message,
  }) => FileTypeRule(allowedMimeTypes: allowedMimeTypes, message: message);

  /// Creates a [FileSizeRule] validation rule.
  ///
  /// This rule validates that the input file size is within a specified limit.
  /// It can include a custom validation message.
  static ValidationRule<File?> fileSize(
    int maxSizeInBytes, {
    String? message,
  }) => FileSizeRule(maxSizeInBytes: maxSizeInBytes, message: message);

  /// Creates a [FileSizeRule] validation rule with the size in megabytes.
  ///
  /// This rule validates that the input file size is within a specified limit.
  /// It can include a custom validation message.
  static ValidationRule<File?> fileSizeInMegabytes(
    int maxSizeInMegabytes, {
    String? message,
  }) => FileSizeRule.megabyte(
    maxSizeInMegabytes: maxSizeInMegabytes,
    message: message,
  );

  static ValidationRule<T> optional<T>() => Optional<T>();
}
