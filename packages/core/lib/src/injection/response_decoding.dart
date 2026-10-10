/// A mixin providing a dynamic response conversion method using factory mapping.
///
/// This mixin offers a flexible way for service providers to convert JSON data into
/// their associated models or entities using a centralized factory map. When a class
/// mixes in `ResponseDecoding`, it can define a [factories] map to specify the
/// conversion logic for different models.
///
/// It's typically used in conjunction with [ServiceProvider] implementations to
/// offer a unified method for transforming JSON data into app-specific models.
///
/// The method [responseConvert] dynamically uses the [factories] map to convert
/// JSON data into the appropriate model. If no conversion is defined for a type,
/// it defaults to returning `null`.
///
/// Usage:
///
/// ```dart
/// class MyServiceProvider with ResponseDecoding {
///   @override
///   Map<Type, JsonFactory> get factories => {
///     MyModel: (json) => MyModel.fromJson(json),
///     AnotherModel: (json) => AnotherModel.fromJson(json),
///     // Add other model factories as needed...
///   };
/// }
/// ```
///
/// This approach centralizes the conversion logic, reducing boilerplate code
/// and making it easier to maintain and scale.
mixin ResponseDecoding {
  /// Converts a JSON map into an instance of type [T], if supported.
  ///
  /// This method uses the [_mappedFactories] map to find the appropriate factory
  /// function for the type [T] and performs the conversion. If no factory is found,
  /// it returns `null`.
  ///
  /// - Parameter [json] The JSON map that needs to be converted.
  /// - Returns: An instance of type [T] if the conversion is successful; otherwise, `null`.
  T? responseConvert<T>(Map<String, dynamic> json) {
    return _responseConvert(json);
  }

  /// Protected method for converting a JSON map into an instance of type [T], if supported.
  ///
  /// This method uses the [_mappedFactories] map to find the appropriate factory
  /// function for the type [T] and performs the conversion. If no factory is found,
  /// it returns `null`.
  ///
  /// - Parameter [json] The JSON map that needs to be converted.
  /// - Returns: An instance of type [T] if the conversion is successful; otherwise, `null`.
  T? _responseConvert<T>(Map<String, dynamic> json) {
    final model = _mappedFactories[T.toString().replaceAll('?', '')]?.call(
      json,
    );
    if (model != null) return model as T;
    return null;
  }

  /// Provides a lazily initialized map of model type names to their corresponding factory functions.
  ///
  /// This getter converts the [factories] map, which uses `Type` as keys, into a
  /// map that uses the string representation of the type as keys. This ensures
  /// compatibility when looking up the factory functions by the string representation
  /// of the type [T].
  late final Map<String, JsonFactory> _mappedFactories = factories.map((
    key,
    value,
  ) {
    return MapEntry(key.toString(), value);
  });

  /// Provides a map of model types to their corresponding factory functions.
  ///
  /// Classes mixing in [ResponseDecoding] should override this getter to define
  /// the JSON conversion logic for different models or entities.
  ///
  /// - Returns: A map where the keys are the model types and the values are the
  ///            corresponding factory functions.
  Map<Type, JsonFactory> get factories;
}

/// A function type that takes a JSON map and returns an instance of a model.
///
/// This typedef defines a factory function for creating an instance of a model
/// from a JSON map.
///
/// - Parameter [json] The JSON map that needs to be converted.
/// - Returns: An instance of the model.
typedef JsonFactory<T> = T Function(Map<String, dynamic> json);
