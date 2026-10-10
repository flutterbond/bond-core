// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_m_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleMResponse<T, G> _$SingleMResponseFromJson<
  T extends Model,
  G extends Jsonable
>(Map<String, dynamic> json) => SingleMResponse<T, G>(
  ResponseConverter<T>().fromJson(json['data'] as Map<String, dynamic>),
  ResponseConverter<G>().fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SingleMResponseToJson<
  T extends Model,
  G extends Jsonable
>(SingleMResponse<T, G> instance) => <String, dynamic>{
  'data': ResponseConverter<T>().toJson(instance.data),
  'meta': ResponseConverter<G>().toJson(instance.meta),
};
