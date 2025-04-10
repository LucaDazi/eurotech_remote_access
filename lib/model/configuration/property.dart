import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class Property {
  Property({
    required this.name,
    required this.array,
    required this.encrypted,
    required this.type,
    required this.value,
  });

  String name;
  bool array;
  bool encrypted;
  String type;
  List<String> value;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
