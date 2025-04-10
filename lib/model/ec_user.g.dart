// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcUser _$EcUserFromJson(Map<String, dynamic> json) => EcUser(
  type: json['type'] as String?,
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  modifiedBy: json['modifiedBy'] as String,
  optlock: (json['optlock'] as num?)?.toInt(),
  name: json['name'] as String,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  expirationDate:
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
  status: json['status'] as String,
  userType: json['userType'] as String,
);

Map<String, dynamic> _$EcUserToJson(EcUser instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'scopeId': instance.scopeId,
  'createdOn': instance.createdOn.toIso8601String(),
  'createdBy': instance.createdBy,
  'modifiedOn': instance.modifiedOn.toIso8601String(),
  'modifiedBy': instance.modifiedBy,
  'optlock': instance.optlock,
  'name': instance.name,
  'displayName': instance.displayName,
  'email': instance.email,
  'expirationDate': instance.expirationDate?.toIso8601String(),
  'status': instance.status,
  'userType': instance.userType,
};
