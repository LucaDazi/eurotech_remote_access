// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routing_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutingRule _$RoutingRuleFromJson(Map<String, dynamic> json) => RoutingRule(
  enabled: json['enabled'] as bool,
  userId: json['userId'] as String,
  accountId: json['accountId'] as String,
  deviceId: json['deviceId'] as String,
  downstreamDeviceName: json['downstreamDeviceName'] as String,
  downstreamDeviceIp: json['downstreamDeviceIp'] as String,
  namespace: json['namespace'] as String,
);

Map<String, dynamic> _$RoutingRuleToJson(RoutingRule instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'userId': instance.userId,
      'accountId': instance.accountId,
      'deviceId': instance.deviceId,
      'downstreamDeviceName': instance.downstreamDeviceName,
      'downstreamDeviceIp': instance.downstreamDeviceIp,
      'namespace': instance.namespace,
    };
