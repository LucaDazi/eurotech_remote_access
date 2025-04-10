// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcConnection _$EcConnectionFromJson(Map<String, dynamic> json) => EcConnection(
  id: json['id'] as String,
  scopeId: json['scopeId'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  createdBy: json['createdBy'] as String,
  modifiedOn: DateTime.parse(json['modifiedOn'] as String),
  optlock: (json['optlock'] as num?)?.toInt(),
  allowUserChange: json['allowUserChange'] as bool?,
  authenticationType: json['authenticationType'] as String?,
  clientId: json['clientId'] as String?,
  clientIp: json['clientIp'] as String?,
  lastAuthenticationType: json['lastAuthenticationType'] as String?,
  protocol: json['protocol'] as String?,
  reservedUserId: json['reservedUserId'] as String?,
  serverIp: json['serverIp'] as String?,
  status: json['status'] as String?,
  userCouplingMode: json['userCouplingMode'] as String?,
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$EcConnectionToJson(EcConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scopeId': instance.scopeId,
      'createdOn': instance.createdOn.toIso8601String(),
      'createdBy': instance.createdBy,
      'modifiedOn': instance.modifiedOn.toIso8601String(),
      'optlock': instance.optlock,
      'allowUserChange': instance.allowUserChange,
      'authenticationType': instance.authenticationType,
      'clientId': instance.clientId,
      'clientIp': instance.clientIp,
      'lastAuthenticationType': instance.lastAuthenticationType,
      'protocol': instance.protocol,
      'reservedUserId': instance.reservedUserId,
      'serverIp': instance.serverIp,
      'status': instance.status,
      'userCouplingMode': instance.userCouplingMode,
      'userId': instance.userId,
    };
