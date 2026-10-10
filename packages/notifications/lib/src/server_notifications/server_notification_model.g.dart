// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerNotificationModel _$ServerNotificationModelFromJson(
  Map<String, dynamic> json,
) => ServerNotificationModel(
  createdAt: DateTime.parse(json['created_at'] as String),
  uuid: json['uuid'] as String,
  code: json['code'] as String,
  body: json['body'] as String,
  title: json['title'] as String,
  senderName: json['sender_name'] as String?,
  senderImage: json['sender_image'] as String?,
  notifiableType: json['notifiable_type'] as String,
  notifiableId: json['notifiable_id'] as int,
  data: json['data'] as Map<String, dynamic>? ?? {},
  readAt: json['read_at'] == null
      ? null
      : DateTime.parse(json['read_at'] as String),
  authableType: json['authable_type'] as String?,
  authableId: json['authable_id'] as int?,
);

Map<String, dynamic> _$ServerNotificationModelToJson(
  ServerNotificationModel instance,
) => <String, dynamic>{
  'uuid': instance.uuid,
  'notifiable_type': instance.notifiableType,
  'notifiable_id': instance.notifiableId,
  'authable_type': instance.authableType,
  'authable_id': instance.authableId,
  'code': instance.code,
  'body': instance.body,
  'title': instance.title,
  'data': instance.data,
  'sender_name': instance.senderName,
  'sender_image': instance.senderImage,
  'read_at': instance.readAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
};
