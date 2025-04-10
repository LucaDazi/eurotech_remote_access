// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcEvent _$EcEventFromJson(Map<String, dynamic> json) => EcEvent(
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  deviceId: json['deviceId'] as String,
  sentOn:
      json['sentOn'] == null ? null : DateTime.parse(json['sentOn'] as String),
  receivedOn:
      json['receivedOn'] == null
          ? null
          : DateTime.parse(json['receivedOn'] as String),
  resource: json['resource'] as String,
  action: json['action'] as String,
  responseCode: json['responseCode'] as String,
);

Map<String, dynamic> _$EcEventToJson(EcEvent instance) => <String, dynamic>{
  'id': instance.id,
  'scopeId': instance.scopeId,
  'createdOn': instance.createdOn.toIso8601String(),
  'createdBy': instance.createdBy,
  'deviceId': instance.deviceId,
  'sentOn': instance.sentOn?.toIso8601String(),
  'receivedOn': instance.receivedOn?.toIso8601String(),
  'resource': instance.resource,
  'action': instance.action,
  'responseCode': instance.responseCode,
};
