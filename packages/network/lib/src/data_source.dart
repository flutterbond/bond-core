import 'dart:convert';

import 'package:dio/dio.dart';

import 'errors/exceptions.dart';
import 'models.dart';

import 'package:bond_core/bond_core.dart';

class DataSource {
  SingleMResponse<T, G> mapSingleMResponse<T extends Model, G extends Jsonable>(
    Response response,
  ) {
    if ((response.statusCode ?? 0) <= 204) {
      return SingleMResponse<T, G>.fromJson(response.data);
    } else {
      throw ServerException.fromResponse(
        json.encode(response.data),
        response.statusCode,
      );
    }
  }

  SingleResponse<T> mapSingleResponse<T extends Model>(
    Response<dynamic> response,
  ) {
    if ((response.statusCode ?? 0) <= 204) {
      return SingleResponse<T>.fromJson(response.data);
    } else {
      throw ServerException.fromResponse(
        json.encode(response.data),
        response.statusCode,
      );
    }
  }

  ListResponse<T> mapListResponse<T extends Model>(Response<dynamic> response) {
    if ((response.statusCode ?? 0) <= 204) {
      return ListResponse<T>.fromJson(response.data);
    } else {
      throw ServerException.fromResponse(
        json.encode(response.data),
        response.statusCode,
      );
    }
  }

  ListMResponse<T, G> mapListMResponse<T extends Model, G extends Jsonable>(
    Response<dynamic> response,
  ) {
    if ((response.statusCode ?? 0) <= 204) {
      return ListMResponse<T, G>.fromJson(response.data);
    } else {
      throw ServerException.fromResponse(
        json.encode(response.data),
        response.statusCode,
      );
    }
  }

  SuccessResponse mapSuccessResponse(Response response) {
    if ((response.statusCode ?? 0) <= 204) {
      return SuccessResponse.fromJson(response.data);
    } else {
      throw ServerException.fromResponse(
        json.encode(response.data),
        response.statusCode,
      );
    }
  }
}
