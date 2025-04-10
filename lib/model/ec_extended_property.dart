import 'package:json_annotation/json_annotation.dart';

part 'ec_extended_property.g.dart';

@JsonSerializable()
class EcExtendedProperty {
  EcExtendedProperty({
    required this.groupName,
    required this.name,
    required this.value,
  });

  String groupName;
  String name;
  String value;

  factory EcExtendedProperty.fromJson(Map<String, dynamic> json) =>
      _$EcExtendedPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$EcExtendedPropertyToJson(this);
}
