import 'dart:convert';

import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';

/// A typedef representing a JSON object commonly used in Dart applications.
///
/// This typedef defines a [Json] type, which is essentially a [Map] with
/// [String] keys and [dynamic] values, typically used to represent JSON data.
/// Usage:
/// ```dart
/// Json jsonData = {'key': 'value', 'number': 42};
/// ```
typedef Json = Map<String, dynamic>;

/// A typedef representing a factory function for deserialization.
///
/// This typedef defines a [Factory<T>] type, which is a function that takes
/// a [Map<String, dynamic>] and returns an instance of type [T]. It is commonly
/// used for converting JSON data into Dart objects or entities.
/// Usage:
/// ```dart
/// Factory<MyModel> myModelFactory = (json) => MyModel.fromJson(json);
/// ```
typedef Factory<T> = T Function(Map<String, dynamic>);

/// An extension on the [Type] class providing utility methods for type checks.
/// Checks whether the type is a primitive type or a list of primitive types.
///
/// Returns `true` if the type is [int], [double], [String], [bool], or a list of [int],
/// [double], [String], or [bool]. Otherwise, returns `false`.
///
/// Usage:
/// ```dart
/// bool isPrimitive = T.primitive; // true
/// ```
extension TypeExtensions on Type {
  bool get primitive {
    // Convert the type to a string and remove any '?' to handle nullability
    final typeStr = toString().replaceAll('?', '');

    // Define a list of primitive types and their List equivalents as strings
    const primitiveTypes = {
      'int',
      'double',
      'String',
      'bool',
      'List<int>',
      'List<double>',
      'List<String>',
      'List<bool>',
    };

    // Check if the non-nullable type string is in the set of primitive types
    return primitiveTypes.contains(typeStr);
  }
}

/// A helper class providing methods for common cache-related operations.
class CommonCacheHelper {
  /// Converts the provided [value] to a cache-friendly string representation.
  ///
  /// This method checks the type of [value] and returns the appropriate string
  /// representation for caching purposes. It supports [Jsonable] objects,
  /// lists of [Jsonable], primitive types (num, String, bool), and lists of
  /// primitive types.
  ///
  /// If the type is unsupported, it throws an [ArgumentError] with a descriptive error message.
  ///
  /// - Parameters:
  ///   - [value] The value to convert.
  ///   - [expiredAfter] The duration for which the cached data is valid.
  /// - Returns: The Map representation of the value including the expiration date.
  /// - Throws: An [ArgumentError] if [value] is of an unsupported type.
  /// Usage:
  /// ```dart
  /// var result = CommonCacheHelper.convertToCacheValue(myValue);
  /// ```
  static Json convertToCacheValue<T>(T value, [Duration? expiredAfter]) {
    try {
      final decodedValue = jsonDecode(jsonEncode(value));
      final expiredAt = expiredAfter == null
          ? null
          : DateTime.now().add(expiredAfter);
      final data = CacheData(data: decodedValue, expiredAt: expiredAt);
      return data.toJson();
    } catch (_) {
      throw ArgumentError(
        'Unsupported type of value: $value. '
        'Tip: for custom object type must be implement the toJson() method.',
      );
    }
  }

  /// Checks and retrieves the cached data of type [T].
  ///
  /// This method validates that the [cachedValue] is of type [T] if it's a primitive type.
  /// If [cachedValue] is a map, it attempts to convert it to type [T] using the provided
  /// [fromJsonFactory] if available. If [fromJsonFactory] is not provided, it checks for
  /// a suitable [ResponseDecoding] provider for conversion.
  ///
  /// - Parameters:
  ///   - [cachedValue] The cached data to check and retrieve.
  ///   - [fromJsonFactory] An optional factory function for custom deserialization.
  /// - Returns: The cached data converted to type [T].
  /// - Throws: An [ArgumentError] if [cachedValue] cannot be converted to type [T].
  /// /// Usage:
  /// ```dart
  /// var result = CommonCacheHelper.checkCachedData(myValue, fromJsonFactory: User.fromJson);
  /// ```
  static T checkCachedData<T>(
    dynamic cachedValue, {
    Factory<T>? fromJsonFactory,
  }) {
    if (T.primitive) {
      assert(
        cachedValue is T,
        'Cached value must be of type $T, but was ${cachedValue.runtimeType}',
      );
      return cachedValue as T;
    }

    if (cachedValue is Map<String, dynamic>) {
      if (fromJsonFactory != null) {
        return fromJsonFactory(cachedValue);
      }
      for (final provider in appProviders.whereType<ResponseDecoding>()) {
        final model = provider.responseConvert<T>(cachedValue);
        if (model != null) {
          return model;
        }
      }
      throw ArgumentError(
        'No ResponseDecoding provider found for type $T. '
        'Make sure to register a class that implements ResponseDecoding '
        'and provides a responseConvert method for type $T. '
        'To register a ResponseDecoding provider, you can do the following:\n\n'
        'class MyServiceProvider extends ServiceProvider with ResponseDecoding {\n'
        '  @override\n'
        '  T? responseConvert<T>(Map<String, dynamic> json) {\n'
        '    if (T == $T) {\n'
        '      return $T.fromJson(json) as T;\n'
        '    }\n'
        '    // Add other model conversions as needed...\n'
        '    return null;\n'
        '  }\n'
        '}\n',
      );
    }

    // Throw an error if T is not a primitive type and provider.responseConvert returns null
    throw ArgumentError(
      'Unhandled case for type $T and cached value: $cachedValue',
    );
  }

  /// Converts a list of cached data to a list of type [T].
  ///
  /// This method checks if [T] is a primitive type (int, double, String, bool, DateTime),
  /// a custom object with a provided [fromJsonFactory], or a custom object using
  /// registered providers implementing [ResponseDecoding].
  ///
  /// If [fromJsonFactory] is provided, it is used to convert each item in the list
  /// to an instance of type [T]. If [fromJsonFactory] is not provided, it looks for
  /// registered providers implementing [ResponseDecoding] to perform the conversion.
  ///
  /// If [T] is a primitive type, the method casts the list items to type [T].
  ///
  /// - Parameters:
  ///   - [cachedList] The list of cached data to be converted.
  ///   - [fromJsonFactory] A factory function for converting each item in the list
  ///                        to an instance of type [T].
  /// - Returns: A list of type [T] representing the converted cached data.
  /// - Throws: An [ArgumentError] if no suitable conversion method is found for type [T].
  ///
  /// Usage:
  /// ```dart
  /// List<MyModel> convertedList = CommonCacheHelper.convertList<MyModel>(cachedList);
  /// ```
  static List<T> convertList<T>(
    List<dynamic> cachedList, {
    Factory<T>? fromJsonFactory,
  }) {
    // Check if T is a primitive type
    if (T.primitive) {
      return cachedList.cast<T>().toList();
    }

    // Check if T is a custom object
    if (fromJsonFactory != null) {
      return cachedList.map((item) => fromJsonFactory(item)).toList();
    }

    // Check if T is a custom object using providers
    for (final provider in appProviders.whereType<ResponseDecoding>()) {
      final models = cachedList
          .map((item) => provider.responseConvert<T>(item))
          .whereType<T>()
          .toList();
      if (models.isNotEmpty) {
        return models;
      }
    }

    // Throw an error if T is not a primitive type and fromJsonFactory is not provided
    throw ArgumentError(
      'No ResponseDecoding provider found for type $T. '
      'Make sure to register a class that implements ResponseDecoding '
      'and provides a responseConvert method for type $T. '
      'To register a ResponseDecoding provider, you can do the following:\n\n'
      'class MyServiceProvider extends ServiceProvider with ResponseDecoding {\n'
      '  @override\n'
      '  T? responseConvert<T>(Map<String, dynamic> json) {\n'
      '    if (T == $T) {\n'
      '      return $T.fromJson(json) as T;\n'
      '    }\n'
      '    // Add other model conversions as needed...\n'
      '    return null;\n'
      '  }\n'
      '}\n',
    );
  }

  /// Checks and retrieves the default value of type [T].
  ///
  /// This method validates that the [defaultValue] is of type [T], or it is
  /// a function returning a value of type [T].
  /// It then returns the appropriate value.
  ///
  /// - Parameters:
  ///   - [defaultValue: The default value or function returning the value.
  /// - Returns: The value of type [T].
  /// - Throws: An [ArgumentError] if the [defaultValue] does not match the expected
  ///   types or if an error occurs while awaiting a future.
  ///
  /// Usage:
  /// ```dart
  /// var value =  checkDefaultValue<int>(42);
  /// ```
  static T checkDefaultValue<T>(dynamic defaultValue) {
    if (defaultValue is T) {
      return defaultValue;
    }

    if (defaultValue is T Function()) {
      return defaultValue();
    }

    throw ArgumentError(
      'defaultValue must be of type $T or a function returning $T',
    );
  }
}
