import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bond_core/bond_core.dart';

import 'meta.dart';

part 'success_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SuccessResponse extends Equatable with Jsonable {
  const SuccessResponse({required this.message, this.meta});

  final String? message;
  final Meta? meta;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);

  @override
  List<Object?> get props => [message, meta];
}
