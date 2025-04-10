// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcDevice _$EcDeviceFromJson(Map<String, dynamic> json) => EcDevice(
  type: json['type'] as String,
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  modifiedBy: json['modifiedBy'] as String,
  optlock: (json['optlock'] as num?)?.toInt(),
  clientId: json['clientId'] as String,
  connectionId: json['connectionId'] as String?,
  connection:
      json['connection'] == null
          ? null
          : EcConnection.fromJson(json['connection'] as Map<String, dynamic>),
  status: json['status'] as String?,
  displayName: json['displayName'] as String?,
  lastEventId: json['lastEventId'] as String?,
  lastEvent:
      json['lastEvent'] == null
          ? null
          : EcEvent.fromJson(json['lastEvent'] as Map<String, dynamic>),
  serialNumber: json['serialNumber'] as String?,
  modelId: json['modelId'] as String?,
  modelName: json['modelName'] as String?,
  biosVersion: json['biosVersion'] as String?,
  firmwareVersion: json['firmwareVersion'] as String?,
  osVersion: json['osVersion'] as String?,
  jvmVersion: json['jvmVersion'] as String?,
  osgiFrameworkVersion: json['osgiFrameworkVersion'] as String?,
  applicationFrameworkVersion: json['applicationFrameworkVersion'] as String?,
  connectionInterface: json['connectionInterface'] as String?,
  connectionIp: json['connectionIp'] as String?,
  applicationIdentifiers: json['applicationIdentifiers'] as String?,
  acceptEncoding: json['acceptEncoding'] as String?,
  customAttribute1: json['customAttribute1'] as String?,
  customAttribute2: json['customAttribute2'] as String?,
  customAttribute3: json['customAttribute3'] as String?,
  customAttribute4: json['customAttribute4'] as String?,
  extendedProperties:
      (json['extendedProperties'] as List<dynamic>?)
          ?.map((e) => EcExtendedProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
  tagIds: (json['tagIds'] as List<dynamic>).map((e) => e as String).toList(),
  visibleInUi: json['visibleInUi'] as bool?,
);

Map<String, dynamic> _$EcDeviceToJson(EcDevice instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'scopeId': instance.scopeId,
  'createdOn': instance.createdOn.toIso8601String(),
  'createdBy': instance.createdBy,
  'modifiedOn': instance.modifiedOn.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'optlock': instance.optlock,
  'clientId': instance.clientId,
  'connectionId': instance.connectionId,
  'connection': instance.connection,
  'status': instance.status,
  'displayName': instance.displayName,
  'lastEventId': instance.lastEventId,
  'lastEvent': instance.lastEvent,
  'serialNumber': instance.serialNumber,
  'modelId': instance.modelId,
  'modelName': instance.modelName,
  'biosVersion': instance.biosVersion,
  'firmwareVersion': instance.firmwareVersion,
  'osVersion': instance.osVersion,
  'jvmVersion': instance.jvmVersion,
  'osgiFrameworkVersion': instance.osgiFrameworkVersion,
  'applicationFrameworkVersion': instance.applicationFrameworkVersion,
  'connectionInterface': instance.connectionInterface,
  'connectionIp': instance.connectionIp,
  'applicationIdentifiers': instance.applicationIdentifiers,
  'acceptEncoding': instance.acceptEncoding,
  'customAttribute1': instance.customAttribute1,
  'customAttribute2': instance.customAttribute2,
  'customAttribute3': instance.customAttribute3,
  'customAttribute4': instance.customAttribute4,
  'extendedProperties': instance.extendedProperties,
  'tagIds': instance.tagIds,
  'visibleInUi': instance.visibleInUi,
};
