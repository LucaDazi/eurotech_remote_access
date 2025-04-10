import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/configuration/partial_configuration.dart';

part 'partial_configurations.g.dart';

@JsonSerializable()
class EcConfigurations {
  EcConfigurations({required this.type, required this.configuration});

  String type;
  List<EcConfiguration> configuration;

  factory EcConfigurations.fromJson(Map<String, dynamic> json) =>
      _$EcConfigurationsFromJson(json);
  Map<String, dynamic> toJson() => _$EcConfigurationsToJson(this);
}
