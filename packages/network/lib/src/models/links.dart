import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bond_core/bond_core.dart';

part 'links.g.dart';

@JsonSerializable()
class Links extends Equatable with Jsonable {
  final String? first;
  final String? last;
  final String? next;
  final String? prev;

  const Links({this.first, this.last, this.next, this.prev});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  List<Object?> get props => [first, last, next, prev];
}
