// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_vpn_configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcVpnConfigs _$EcVpnConfigsFromJson(Map<String, dynamic> json) => EcVpnConfigs(
  limitExceeded: json['limitExceeded'] as bool,
  size: (json['size'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>)
          .map((e) => EcVpnConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$EcVpnConfigsToJson(EcVpnConfigs instance) =>
    <String, dynamic>{
      'limitExceeded': instance.limitExceeded,
      'size': instance.size,
      'items': instance.items,
    };
