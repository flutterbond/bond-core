import 'package:bond_network/bond_network.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_notification_model.g.dart';

@JsonSerializable()
class ServerNotificationModel extends Model {
  final String uuid;
  @JsonKey(name: 'notifiable_type')
  final String notifiableType;
  @JsonKey(name: 'notifiable_id')
  final int notifiableId;
  @JsonKey(name: 'authable_type')
  final String? authableType;
  @JsonKey(name: 'authable_id')
  final int? authableId;
  final String code;
  final String title;
  final String body;
  @JsonKey(defaultValue: {})
  final Map<String, dynamic> data;
  @JsonKey(name: 'sender_name')
  final String? senderName;
  @JsonKey(name: 'sender_image')
  final String? senderImage;
  @JsonKey(name: 'read_at')
  final DateTime? readAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const ServerNotificationModel({
    required this.createdAt,
    required this.uuid,
    required this.code,
    required this.body,
    required this.title,
    this.senderName,
    this.senderImage,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    this.readAt,
    this.authableType,
    this.authableId,
  }) : super(id: -1);

  bool get read => readAt != null;

  factory ServerNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ServerNotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServerNotificationModelToJson(this);

  ServerNotificationModel copyWith({
    String? uuid,
    String? notifiableType,
    int? notifiableId,
    String? authableType,
    int? authableId,
    String? code,
    String? body,
    String? title,
    Map<String, dynamic>? data,
    String? senderName,
    String? senderImage,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return ServerNotificationModel(
      uuid: uuid ?? this.uuid,
      notifiableType: notifiableType ?? this.notifiableType,
      notifiableId: notifiableId ?? this.notifiableId,
      authableType: authableType ?? this.authableType,
      authableId: authableId ?? this.authableId,
      code: code ?? this.code,
      body: body ?? this.body,
      data: data ?? this.data,
      title: title ?? this.title,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    uuid,
    notifiableType,
    notifiableId,
    authableType,
    authableId,
    code,
    body,
    data,
    senderName,
    senderImage,
    readAt,
    createdAt,
    title,
  ];
}

enum SeverNotificationChangedType { loadingNextPage, loaded }
