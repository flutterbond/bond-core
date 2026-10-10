// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_m_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMResponse<T, G> _$ListMResponseFromJson<
  T extends Model,
  G extends Jsonable
>(Map<String, dynamic> json) => ListMResponse<T, G>(
  (json['data'] as List<dynamic>)
      .map((e) => ResponseConverter<T>().fromJson(e as Map<String, dynamic>))
      .toList(),
  ResponseConverter<G>().fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ListMResponseToJson<T extends Model, G extends Jsonable>(
  ListMResponse<T, G> instance,
) => <String, dynamic>{
  'data': instance.data.map(ResponseConverter<T>().toJson).toList(),
  'meta': ResponseConverter<G>().toJson(instance.meta),
};
