// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_vpn_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcVpnConfig _$EcVpnConfigFromJson(Map<String, dynamic> json) => EcVpnConfig(
  id: json['id'] as String,
  name: json['name'] as String,
  configurationFile: json['configurationFile'] as String,
);

Map<String, dynamic> _$EcVpnConfigToJson(EcVpnConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'configurationFile': instance.configurationFile,
    };
