import 'package:bond_core/bond_core.dart';
import 'package:dio/dio.dart';

import 'base_bond_api_request.dart';

/// A fluent HTTP client built on top of Dio.
///
/// Each method starts a request that you configure and then run with
/// `execute()`:
///
/// ```dart
/// final user = await BondFire()
///     .get<User>('/users/me')
///     .factory(User.fromJson)
///     .errorFactory(ServerError.fromJson)
///     .execute();
/// ```
///
/// BondFire is not a singleton: every instance sends requests with the [Dio]
/// registered in the service locator (`sl<Dio>()`), so register [Dio] first.
/// Apps usually register one BondFire as well, e.g.
/// `it.registerLazySingleton<BondFire>(BondFire.new)`, and inject it into
/// their API classes.
class BondFire {
  /// The internal [Dio] instance used for making HTTP requests.
  final Dio _dio;

  /// Creates a client that uses the [Dio] registered in the service locator.
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
