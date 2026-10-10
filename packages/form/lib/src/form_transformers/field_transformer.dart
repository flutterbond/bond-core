/// A typedef representing a function that transforms a field value
/// from one type to another.
///
/// Parameters:
///   - [T] The input type (the original field value).
///   - [G] The output type (the transformed value).
typedef FieldTransformer<T, G extends Object?> = G Function(T value);

/// A factory class that wraps a transformation function, allowing
/// it to be used within the `TransformersRegistry`.
class FieldTransformerFactory<T, G extends Object?> {
  final FieldTransformer<T, G> transformationFunction;

  FieldTransformerFactory({required this.transformationFunction});

  /// Transforms a value using the wrapped transformation function.
  ///
  /// Parameters:
  ///   - [value] The value to be transformed.
  ///
  /// Returns: The transformed value.
  G transform(dynamic value) {
    return transformationFunction.call(value as T);
  }
}
