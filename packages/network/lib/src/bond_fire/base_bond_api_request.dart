import 'dart:convert';
import 'dart:io';

import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:dio/dio.dart';

part 'cache_policy.dart';
part 'get_bond_api_request.dart';

/// A typedef for a data transformer function.
///
/// This function is used to transform raw response data into a map
/// with `String` keys and `dynamic` values. It takes the raw data
/// as input and returns a transformed map.
typedef DataTransformer = Map<String, dynamic> Function(dynamic data);

/// A typedef for a factory function that converts JSON data to a model of type [T].
///
/// This function takes a `Map<String, dynamic>` representing JSON data
/// and returns an instance of type [T].
typedef Factory<T> = T Function(Map<String, dynamic>);

/// A typedef for a factory function that converts JSON error responses to a custom [Error].
///
/// This function takes a `Map<String, dynamic>` representing a JSON error response
/// and returns an instance of a custom [Error] of type [T].
typedef ErrorFactory<T extends Error> = T Function(Map<String, dynamic>);

/// Internal class representing a custom cache key configuration.
///
/// - [path]: The dot-separated path to the field in the response data to cache.
/// - [put]: A function to store the extracted value in the cache.
class _CustomCacheKey {
  final String path;
  final Future<bool> Function(dynamic value) put;

  /// Creates a [_CustomCacheKey] with the specified [path] and [put] function.
  _CustomCacheKey(this.path, this.put);
}

/// Represents a base class
/// for configuring and executing HTTP requests using Dio
/// with additional features such as custom header, body, files, cache and error handling.
class BaseBondApiRequest<T> {
  /// The Dio instance used to execute HTTP requests.
  final Dio _dio;

  /// The path of the API endpoint for the request.
  final String _path;

  /// The HTTP method (e.g., GET, POST, etc.) used for the request.
  final String _method;

  /// A map of custom headers to be included in the request.
  Map<String, String> _headers = <String, String>{};

  /// A map of query parameters to be appended to the request URL.
  Map<String, dynamic> _queryParameters = <String, dynamic>{};

  /// The JSON body to be sent with the request, if applicable.
  Map<String, dynamic>? _body;

  /// A map of files to be attached to the request as multipart form data.
  Map<String, File>? _files;

  /// Additional form-data to be included alongside files in the request.
  Map<String, dynamic>? _data;

  /// A token used to cancel the request if needed.
  CancelToken? _cancelToken;

  /// A function to transform the raw response data into a desired format.
  DataTransformer? _dataTransformer;

  /// A factory function to convert the response body into a model of type [T].
  Factory<T>? _factory;

  /// A factory function to convert error responses into custom [Error] objects.
  ErrorFactory? _errorFactory;

  /// A map of custom cache keys and their corresponding paths in the response data.
  final Map<String, _CustomCacheKey> _customCacheKeys = {};

  /// Constructs a new instance of [BaseBondApiRequest].
  ///
  /// - Parameters:
  ///   - [dio]: The Dio instance used to execute HTTP requests.
  ///   - [path]: The path of the API endpoint for the request.
  ///   - [method]: The HTTP method (e.g., GET, POST, etc.) used for the request.
  BaseBondApiRequest(this._dio, String path, {required this._method})
    : _path = path;

  /// Adds custom headers to the request.
  ///
  /// Parameters:
  /// - [headers]: A map of headers to be added to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> header(Map<String, String> headers) {
    _headers = headers;
    return this;
  }

  /// Adds query parameters to the request.
  ///
  /// -Parameters:
  ///  - [queryParameters]: A map of query parameters to be added to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> queryParameters(Map<String, dynamic> queryParameters) {
    _queryParameters = queryParameters;
    return this;
  }

  /// Sets a JSON body for the request.
  ///
  /// -Parameters:
  /// - [body]: A map representing the JSON body to be sent with the request.
  ///
  ///  Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> body(Map<String, dynamic> body) {
    _body = body;
    return this;
  }

  /// Attaches files to the request using a multipart form.
  ///
  /// -Parameters:
  /// - [files]: A map of file paths to be attached to the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> files(Map<String, File> files) {
    _files = files;
    return this;
  }

  /// Sets form-data to be included alongside files in the request.
  ///
  /// -Parameters:
  /// - [data]: A map representing the form-data to be sent with the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> data(Map<String, dynamic> data) {
    _data = data;
    return this;
  }

  /// Sets a data transformer function to process the response data.
  ///
  /// This method allows you to provide a custom transformer function that
  /// processes the raw response data before it is returned. The transformer
  /// function takes the raw response data as input and returns a transformed
  /// map.
  ///
  /// - Parameters:
  ///   - [transformer]: A function that takes the raw response data (dynamic)
  ///     and returns a transformed map (`Map<String, dynamic>`).
  ///
  /// - Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> transform(DataTransformer transformer) {
    _dataTransformer = transformer;
    return this;
  }

  /// A shorthand method for setting a data transformer function.
  ///
  /// This method is equivalent to calling [transform] and is provided
  /// for convenience. It sets a custom transformer function to process
  /// the raw response data.
  ///
  /// - Parameters:
  ///   - [transformer]: A function that takes the raw response data (dynamic)
  ///     and returns a transformed map (`Map<String, dynamic>`).
  ///
  /// - Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> map(DataTransformer transformer) =>
      transform(transformer);

  /// Adds a cancel token to the request.
  ///
  /// -Parameters:
  /// - [cancelToken]: A [CancelToken] instance used to cancel the request.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> cancelToken(CancelToken cancelToken) {
    _cancelToken = cancelToken;
    return this;
  }

  /// Sets a factory function to convert the response body to a model of type [T].
  ///
  /// -Parameters:
  /// - [factory]: A function that takes a JSON map and returns an instance of type [T].
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> factory(Factory<T> factory) {
    _factory = factory;
    return this;
  }

  /// Sets an error factory to convert failed responses into custom [Error]s.
  ///
  /// -Parameters:
  /// - [errorFactory]: A function that takes a JSON map and returns an instance of type [Error].
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> errorFactory(ErrorFactory errorFactory) {
    _errorFactory = errorFactory;
    return this;
  }

  /// Adds a custom cache key configuration for caching a specific field from the response.
  ///
  /// - [key]: The cache key under which the value will be stored.
  /// - [path]: The dot-separated path to the field in the response data to cache.
  /// - [store]: Optional. The name of the cache store to use. If not provided, the default store is used.
  ///
  /// Returns: The current [BaseBondApiRequest] instance for chaining.
  BaseBondApiRequest<T> cacheCustomKey<V>(
    String key, {
    required String path,
    String? store,
    Factory? factory,
  }) {
    _customCacheKeys[key] = _CustomCacheKey(path, (value) async {
      V? model;
      if (factory != null) {
        model = factory(value);
      } else {
        model = _getModel<V>(value);
      }
      if (model == null) {
        return false;
      }
      if (store != null) {
        await Cache.store(store).put<V>(key, model);
      } else {
        await Cache.put<V>(key, model);
      }
      return true;
    });
    return this;
  }

  /// Executes the request and returns the processed result.
  ///
  /// - Returns: A [Future] that resolves to the response of type [T].
  Future<T> execute() async {
    try {
      final data = await _getRequestData();
      final response = await _dio.request(
        _path,
        queryParameters: _queryParameters,
        data: data,
        options: Options(method: _method, headers: _headers),
        cancelToken: _cancelToken,
      );

      dynamic responseData = response.data;

      if (_dataTransformer != null) {
        responseData = _dataTransformer!(responseData);
      }

      if (_customCacheKeys.entries.isNotEmpty) {
        await _cacheCustomKeys(responseData);
      }

      if (_factory != null) {
        return _factory!(responseData);
      } else {
        for (final provider in appProviders.whereType<ResponseDecoding>()) {
          final model = provider.responseConvert<T>(responseData);
          if (model != null) {
            return model;
          }
        }
        return responseData;
      }
    } on DioException catch (error) {
      if (_errorFactory != null && error.response != null) {
        final data = error.response!.data;
        if (data is Map<String, dynamic>) {
          throw _errorFactory!(data);
        } else if (data is String) {
          throw _errorFactory!(jsonDecode(data));
        } else {
          rethrow;
        }
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  /// Prepares data for the request body.
  Future<dynamic> _getRequestData() async {
    if (_files != null && _files!.isNotEmpty) {
      return await _createFormData(files: _files!, data: _data);
    } else {
      return _body;
    }
  }

  /// Caches specified fields from the response into local storage.
  Future<void> _cacheCustomKeys(Map<String, dynamic> result) async {
    for (final entry in _customCacheKeys.entries) {
      final custom = entry.value;
      final value = _getNestedValue(result, custom.path);
      if (value != null) {
        await custom.put(value); // This will call Cache.put<V>(...)
      }
    }
    // Ensure all microtasks from cache writes complete before returning.
    // This is necessary because some cache drivers (e.g., FlutterSecureStorage mock)
    // schedule their completion on the microtask queue.
    await Future<void>.delayed(Duration.zero);
  }

  /// Extracts a nested field value from a map based on a dot-separated path.
  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    final keys = key.split('.');
    dynamic value = map;
    for (final k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return null;
      }
    }
    return value;
  }

  /// Creates a FormData instance for uploading files and data.
  Future<FormData> _createFormData({
    required Map<String, File> files,
    Map<String, dynamic>? data,
  }) async {
    final formData = FormData();

    for (final entry in files.entries) {
      final fieldName = entry.key;
      final file = entry.value;
      formData.files.add(
        MapEntry(fieldName, await MultipartFile.fromFile(file.path)),
      );
    }

    if (data != null) {
      for (final entry in data.entries) {
        final fieldName = entry.key;
        final value = entry.value;
        formData.fields.add(MapEntry(fieldName, value.toString()));
      }
    }

    return formData;
  }

  /// Converts a dynamic value to a model of type [V].
  ///
  /// If [V] is a primitive type, asserts that the value is of type [T] and casts it.
  /// Otherwise, attempts to convert the value using available [ResponseDecoding] providers.
  /// Returns the converted model or `null` if conversion fails.
  V? _getModel<V>(dynamic value) {
    if (V.primitive) {
      assert(
        value is V,
        'Cached value must be of type $V, but was ${value.runtimeType}',
      );
      return value as V;
    }

    for (final provider in appProviders.whereType<ResponseDecoding>()) {
      final model = provider.responseConvert<V>(value);
      if (model != null) {
        return model;
      }
    }
    return null;
  }
}

extension _TypeExtensions on Type {
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
