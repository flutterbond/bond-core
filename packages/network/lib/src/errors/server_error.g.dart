// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerError _$ServerErrorFromJson(Map<String, dynamic> json) => ServerError(
  message: json['message'] as String? ?? 'Unexpected server error',
  code: json['code'] as String? ?? 'unknown',
);

Map<String, dynamic> _$ServerErrorToJson(ServerError instance) =>
    <String, dynamic>{'message': instance.message, 'code': instance.code};
