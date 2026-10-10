import 'package:bond_core/bond_core.dart';
import 'package:dio/dio.dart';

import 'base_bond_api_request.dart';

/// BondApiClient is a simple API client built on top of Dio.
/// BondFire is a singleton API client built on top of Dio.
class BondFire {
  /// The internal [Dio] instance used for making HTTP requests.
  final Dio _dio;

  /// Private constructor for initializing the [Dio] instance.
  BondFire() : _dio = sl<Dio>();

  /// Creates a GET request for the specified [path].
  ///
  /// - [T]: The type of the response model, which must extend [Jsonable].
  /// - [path]: The endpoint path for the GET request.
  ///
  /// Returns: A [GetBondApiRequest] instance for chaining and execution.
  GetBondApiRequest<T> get<T extends Jsonable>(String path) =>
      GetBondApiRequest<T>(_dio, path);

  /// Creates a POST request for the specified [path].
  ///
  /// - [T]: The type of the response model.
  /// - [path]: The endpoint path for the POST request.
  ///
  /// Returns: A [BaseBondApiRequest] instance for chaining and execution.
  BaseBondApiRequest<T> post<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'POST');

  /// Creates a PUT request for the specified [path].
  ///
  /// - [T]: The type of the response model.
  /// - [path]: The endpoint path for the PUT request.
  ///
  /// Returns: A [BaseBondApiRequest] instance for chaining and execution.
  BaseBondApiRequest<T> put<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'PUT');

  /// Creates a PATCH request for the specified [path].
  ///
  /// - [T]: The type of the response model.
  /// - [path]: The endpoint path for the PATCH request.
  ///
  /// Returns: A [BaseBondApiRequest] instance for chaining and execution.
  BaseBondApiRequest<T> patch<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'PATCH');

  /// Creates a DELETE request for the specified [path].
  ///
  /// - [T]: The type of the response model.
  /// - [path]: The endpoint path for the DELETE request.
  ///
  /// Returns: A [BaseBondApiRequest] instance for chaining and execution.
  BaseBondApiRequest<T> delete<T>(String path) =>
      BaseBondApiRequest<T>(_dio, path, method: 'DELETE');
}
