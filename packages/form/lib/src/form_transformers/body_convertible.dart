import 'package:bond_form/bond_form.dart';

/// A mixin that adds functionality to convert form state into a
/// map of key-value pairs suitable for creating a request body.
///
/// This mixin provides:
/// - Transformation of form fields using registered transformers.
/// - Options to ignore certain keys, empty values, or remap keys.
/// - Support for merging nested maps and post-processing the body.
mixin BodyConvertible<
  Success,
  Failure extends Error,
  State extends BaseBondFormState<Success, Failure>
>
    on BaseFormController<Success, Failure, State> {
  /// Generates a map from the form state, applying any transformations
  /// specified by the [fieldTransformers] method.
  ///
  /// This method iterates over all fields in the form state, applies
  /// any registered transformers, and returns a map suitable for use
  /// as a request body.
  ///
  /// It also respects the options:
  /// - [ignoredBodyKeys]
  /// - [ignoreEmptyValues]
  /// - [remapKeys]
  /// - [mergeNestedMaps]
  /// - [postProcessBody]
  ///
  /// Returns a `Map<String, dynamic>` containing the transformed form data.
  Map<String, dynamic> body() {
    final registry = TransformersRegistry();
    fieldTransformers(registry);

    final raw = <String, dynamic>{};

    // Iterate through each field in the fields map
    state.fields.forEach((fieldName, fieldState) {
      // Skip ignored fields
      if (ignoredBodyKeys.contains(fieldName)) return;

      final fieldValue = fieldState.value;
      final transformed = registry.transform(fieldValue, fieldKey: fieldName);
      final value = transformed ?? fieldValue;

      // Skip empty/null values if enabled
      if (ignoreEmptyValues &&
              (value == null || (value is String && value.trim().isEmpty)) ||
          (value is List && value.isEmpty) ||
          (value is Set && value.isEmpty)) {
        return;
      }

      // Determine final key
      final key = remapKeys[fieldName] ?? fieldName;

      // Support nested merging of transformer output
      if (mergeNestedMaps && value is Map<String, dynamic>) {
        raw.addAll(value);
      } else {
        raw[key] = value;
      }
    });

    return postProcessBody(raw);
  }

  /// Registers transformers for specific field types or keys.
  ///
  /// Subclasses should implement this method to register any custom
  /// transformers needed to convert field values to the appropriate
  /// types for the request body.
  ///
  /// Parameters:
  ///   - [registry] The [TransformersRegistry] instance where
  ///     transformers should be registered.
  void fieldTransformers(TransformersRegistry registry) {}

  /// Fields listed here will be excluded from the request body.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Set<String> get ignoredBodyKeys => {'cardToken', 'cardLastFour'};
  /// ```
  Set<String> get ignoredBodyKeys => {};

  /// Whether to exclude `null`, empty `String`, and `int == 0` from the body.
  ///
  /// Defaults to `true`. Set to `false` if you want to allow those values.
  bool get ignoreEmptyValues => true;

  /// Remap field keys before placing them into the final request body.
  ///
  /// For example:
  /// ```dart
  /// @override
  /// Map<String, String> get remapKeys => {'address': 'addressId'};
  /// ```
  Map<String, String> get remapKeys => {};

  /// If a transformed value is a `Map<String, dynamic>`, merge it into
  /// the root instead of assigning to a single key.
  ///
  /// Example use case: a transformer returns a nested object that needs
  /// to be flattened into the parent body structure.
  bool get mergeNestedMaps => false;

  /// Optionally apply post-processing to the body map.
  ///
  /// This is useful for cleaning up keys, converting naming styles,
  /// adding additional values, or validating structure.
  Map<String, dynamic> postProcessBody(Map<String, dynamic> body) => body;
}
