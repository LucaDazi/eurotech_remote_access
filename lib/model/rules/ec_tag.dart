import 'package:json_annotation/json_annotation.dart';

part 'ec_tag.g.dart';

@JsonSerializable()
class EcTag {
  EcTag({
    required this.id,
    required this.name,
    this.optlock,
    required this.description,
  });

  String id;
  String name;
  String description;
  int? optlock;

  factory EcTag.fromJson(Map<String, dynamic> json) => _$EcTagFromJson(json);
  Map<String, dynamic> toJson() => _$EcTagToJson(this);
}
