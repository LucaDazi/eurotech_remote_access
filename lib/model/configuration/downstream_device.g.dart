// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downstream_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownstreamDevice _$DownstreamDeviceFromJson(Map<String, dynamic> json) =>
    DownstreamDevice(
      name: json['name'] as String,
      type: json['type'] as String,
      iPv4: json['IPv4'] as String,
      namespace: json['namespace'] as String?,
    );

Map<String, dynamic> _$DownstreamDeviceToJson(DownstreamDevice instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'IPv4': instance.iPv4,
      'namespace': instance.namespace,
    };
