import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(explicitToJson: true)
class Meta {
  const Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
    this.message,
  });

  @JsonKey(name: 'current_page')
  final int? currentPage;
  final int? from;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  final String? path;
  @JsonKey(name: 'per_page')
  final int? perPage;
  final int? to;
  final int? total;
  final String? message;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
