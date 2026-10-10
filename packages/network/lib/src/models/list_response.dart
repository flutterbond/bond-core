import 'package:bond_core/bond_core.dart';
import 'package:bond_network/src/converters.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'links.dart';
import 'meta.dart';
import 'model.dart';

part 'list_response.g.dart';

/// A generic class for list responses from an API.
///
/// The class includes a list of data of type `T`, along with optional
/// metadata ([Meta]) and pagination links ([Links]).
@JsonSerializable(explicitToJson: true)
class ListResponse<T extends Model> extends Equatable with Jsonable {
  /// Creates a [ListResponse].
  ///
  /// [data] must not be null. [meta] and [links] are optional.
  const ListResponse({required this.data, this.meta, this.links});

  /// The list of data objects of type `T`.
  @ResponseConverter()
  final List<T> data;

  /// Metadata about the list, if available.
  final Meta? meta;

  /// Links for pagination, if available.
  final Links? links;

  /// Creates a [ListResponse] instance from a JSON map.
  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);

  /// Serializes this [ListResponse] to a JSON map.
  @override
  Map<String, dynamic> toJson() => _$ListResponseToJson(this);

  /// Creates a copy of this [ListResponse] but with the given fields
  /// replaced with the new values.
  ListResponse<T> copyWith({List<T>? data, Meta? meta, Links? links}) {
    return ListResponse<T>(
      data: data ?? this.data,
      meta: meta ?? this.meta,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [data, meta, links];
}
