import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/configuration/property.dart';

part 'properties.g.dart';

@JsonSerializable()
class Properties {
  Properties({required this.property});

  List<Property> property;

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
