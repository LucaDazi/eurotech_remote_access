// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcInstance _$EcInstanceFromJson(Map<String, dynamic> json) => EcInstance(
  consoleEndpoint: json['console_endpoint'] as String,
  country: json['country'] as String,
  friendlyName: json['friendly_name'] as String,
  id: json['id'] as String,
  provisionEndpoint: json['provision_endpoint'] as String,
  region: json['region'] as String,
  subRegion: json['sub_region'] as String,
  type: json['type'] as String,
  apiEndpoint: json['apiEndpoint'] as String?,
);

Map<String, dynamic> _$EcInstanceToJson(EcInstance instance) =>
    <String, dynamic>{
      'console_endpoint': instance.consoleEndpoint,
      'country': instance.country,
      'friendly_name': instance.friendlyName,
      'id': instance.id,
      'provision_endpoint': instance.provisionEndpoint,
      'region': instance.region,
      'sub_region': instance.subRegion,
      'type': instance.type,
      'apiEndpoint': instance.apiEndpoint,
    };
