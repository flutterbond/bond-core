import 'package:json_annotation/json_annotation.dart';

part 'server_error.g.dart';

@JsonSerializable()
class ServerError extends Error {
  ServerError({required this.message, required this.code});

  final String message;
  final String code;

  factory ServerError.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorToJson(this);

  @override
  String toString() => 'ServerError: $message ($code)';
}
