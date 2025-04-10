import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  Ad({
    required this.cardinality,
    required this.description,
    required this.id,
    required this.name,
    required this.required,
    required this.type,
  });

  int cardinality;
  String description;
  String id;
  String name;
  bool required;
  String type;

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);
  Map<String, dynamic> toJson() => _$AdToJson(this);
}
