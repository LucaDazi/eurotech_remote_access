// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  type: json['type'] as String?,
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  modifiedBy: json['modifiedBy'] as String,
  optLock: (json['optLock'] as num?)?.toInt(),
  tokenId: json['tokenId'] as String,
  userId: json['userId'] as String,
  expiresOn: DateTime.parse(json['expiresOn'] as String),
  refreshToken: json['refreshToken'] as String,
  refreshExpiresOn: DateTime.parse(json['refreshExpiresOn'] as String),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'scopeId': instance.scopeId,
      'createdOn': instance.createdOn.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiedOn': instance.modifiedOn.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'optLock': instance.optLock,
      'tokenId': instance.tokenId,
      'userId': instance.userId,
      'expiresOn': instance.expiresOn.toIso8601String(),
      'refreshToken': instance.refreshToken,
      'refreshExpiresOn': instance.refreshExpiresOn.toIso8601String(),
    };
