// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcAccount _$EcAccountFromJson(Map<String, dynamic> json) => EcAccount(
  type: json['type'] as String,
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  modifiedBy: json['modifiedBy'] as String,
  name: json['name'] as String,
  optlock: (json['optlock'] as num?)?.toInt(),
  organization: EcOrganization.fromJson(
    json['organization'] as Map<String, dynamic>,
  ),
  parentAccountPath: json['parentAccountPath'] as String,
  visibleInUi: json['visibleInUi'] as bool?,
);

Map<String, dynamic> _$EcAccountToJson(EcAccount instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'scopeId': instance.scopeId,
  'createdOn': instance.createdOn.toIso8601String(),
  'createdBy': instance.createdBy,
  'modifiedOn': instance.modifiedOn.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'name': instance.name,
  'optlock': instance.optlock,
  'organization': instance.organization,
  'parentAccountPath': instance.parentAccountPath,
  'visibleInUi': instance.visibleInUi,
};
