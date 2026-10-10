import 'dart:convert';

import 'package:dio/dio.dart';

import 'errors/exceptions.dart';

class ApiClient {
  final Dio client;

  ApiClient(this.client);

  Future<Response> get(
    String url, {
    required Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await client.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (e) {
      throw ServerException(errors: {'message': '$e'});
    }
  }

  Future<Response> post(
    String url, {
    required Map<String, String>? headers,
    body,
  }) async {
    try {
      return await client.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (e) {
      throw ServerException(errors: {'message': '$e'});
    }
  }

  Future<Response> postUri(
    Uri uri, {
    Map<String, String>? headers,
    body,
  }) async {
    try {
      return await client.postUri(
        uri,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (e) {
      throw ServerException(errors: {'message': '$e'});
    }
  }

  Future<Response> put(
    String url, {
    required Map<String, dynamic> headers,
    body,
    Encoding? encoding,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      return await client.put(
        url,
        data: body,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (e) {
      throw ServerException(errors: {'message': '$e'});
    }
  }

  Future<Response> delete(
    String url, {
    required Map<String, String> headers,
    body,
    queryParameters,
  }) async {
    try {
      return await client.delete(
        url,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (e) {
      throw ServerException(errors: {'message': '$e'});
    }
  }

  ServerException _handleDioError(DioException error) {
    if (error.response != null && error.response!.data != null) {
      return ServerException(
        errors: error.response!.data,
        statusCode: error.response?.statusCode,
      );
    }
    return ServerException(
      errors: {'message': '$error'},
      statusCode: error.response?.statusCode,
    );
  }
}
