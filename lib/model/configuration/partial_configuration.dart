import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/configuration/properties.dart';

part 'partial_configuration.g.dart';

@JsonSerializable()
class EcConfiguration {
  EcConfiguration({required this.id, required this.properties});

  String id;
  Properties properties;

  factory EcConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EcConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$EcConfigurationToJson(this);
}
