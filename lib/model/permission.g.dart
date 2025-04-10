// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
  domain: json['domain'] as String?,
  action: json['action'] as String?,
  targetScopeId: json['targetScopeId'] as String,
  forwardable: json['forwardable'] as bool,
);

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'action': instance.action,
      'targetScopeId': instance.targetScopeId,
      'forwardable': instance.forwardable,
    };
