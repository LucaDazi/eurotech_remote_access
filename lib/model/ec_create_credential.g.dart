// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_create_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcCreateCredential _$EcCreateCredentialFromJson(Map<String, dynamic> json) =>
    EcCreateCredential(
      userId: json['userId'] as String,
      credentialType: json['credentialType'] as String,
      credentialKey: json['credentialKey'] as String?,
      credentialStatus: json['credentialStatus'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$EcCreateCredentialToJson(EcCreateCredential instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'credentialType': instance.credentialType,
      'credentialKey': instance.credentialKey,
      'credentialStatus': instance.credentialStatus,
      'expirationDate': instance.expirationDate.toIso8601String(),
    };
