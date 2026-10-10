// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerError _$ServerErrorFromJson(Map<String, dynamic> json) => ServerError(
  message: json['message'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$ServerErrorToJson(ServerError instance) =>
    <String, dynamic>{'message': instance.message, 'code': instance.code};
