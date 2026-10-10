import 'package:bond_core/bond_core.dart';
import 'package:bond_network/src/converters.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model.dart';

part 'list_m_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ListMResponse<T extends Model, G extends Jsonable> extends Equatable
    with Jsonable {
  @ResponseConverter()
  final List<T> data;
  @ResponseConverter()
  final G meta;

  const ListMResponse(this.data, this.meta);

  @override
  Map<String, dynamic> toJson() => _$ListMResponseToJson(this);

  factory ListMResponse.fromJson(Map<String, dynamic> json) =>
      _$ListMResponseFromJson(json);

  ListMResponse<T, G> copyWith({List<T>? data, G? meta}) {
    return ListMResponse<T, G>(data ?? this.data, meta ?? this.meta);
  }

  @override
  List<Object?> get props => [data, meta];
}
