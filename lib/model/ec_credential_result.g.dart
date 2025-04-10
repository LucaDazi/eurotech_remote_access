// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_credential_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcCredentialResult _$EcCredentialResultFromJson(Map<String, dynamic> json) =>
    EcCredentialResult(
      type: json['type'] as String,
      id: json['id'] as String,
      scopeId: json['scopeId'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      createdBy: json['createdBy'] as String,
      modifiedOn: DateTime.parse(json['modifiedOn'] as String),
      modifiedBy: json['modifiedBy'] as String,
      optlock: (json['optlock'] as num?)?.toInt(),
      credentialKey: json['credentialKey'] as String?,
      credentialType: json['credentialType'] as String,
      expirationDate:
          json['expirationDate'] == null
              ? null
              : DateTime.parse(json['expirationDate'] as String),
      loginFailures: (json['loginFailures'] as num).toInt(),
      status: json['status'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$EcCredentialResultToJson(EcCredentialResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'scopeId': instance.scopeId,
      'createdOn': instance.createdOn.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiedOn': instance.modifiedOn.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'optlock': instance.optlock,
      'credentialKey': instance.credentialKey,
      'credentialType': instance.credentialType,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'loginFailures': instance.loginFailures,
      'status': instance.status,
      'userId': instance.userId,
    };
