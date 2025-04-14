import 'package:json_annotation/json_annotation.dart';

part 'ec_vpn_config.g.dart';

@JsonSerializable()
class EcVpnConfig {
  EcVpnConfig({
    required this.id,
    required this.name,
    required this.configurationFile,
  });

  String id;
  String name;
  String configurationFile;

  factory EcVpnConfig.fromJson(Map<String, dynamic> json) =>
      _$EcVpnConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EcVpnConfigToJson(this);
}
