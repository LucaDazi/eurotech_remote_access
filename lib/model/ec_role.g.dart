// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcRole _$EcRoleFromJson(Map<String, dynamic> json) => EcRole(
  type: json['type'] as String?,
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  modifiedBy: json['modifiedBy'] as String,
  optlock: (json['optlock'] as num?)?.toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$EcRoleToJson(EcRole instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'scopeId': instance.scopeId,
  'createdOn': instance.createdOn.toIso8601String(),
  'createdBy': instance.createdBy,
  'modifiedOn': instance.modifiedOn.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'optlock': instance.optlock,
  'name': instance.name,
};
