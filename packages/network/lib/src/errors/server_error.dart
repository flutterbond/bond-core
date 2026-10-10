import 'package:json_annotation/json_annotation.dart';

part 'server_error.g.dart';

@JsonSerializable()
class ServerError extends Error {
  ServerError({required this.message, required this.code});

  /// Falls back to a generic text when the body has no `message` (e.g. an
  /// AWS Lambda function URL answering 403 with `{"Message": null}`), so a
  /// foreign error body still maps to a [ServerError] instead of a TypeError.
  @JsonKey(defaultValue: 'Unexpected server error')
  final String message;
  @JsonKey(defaultValue: 'unknown')
  final String code;

  factory ServerError.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorToJson(this);

  @override
  String toString() => 'ServerError: $message ($code)';
}
