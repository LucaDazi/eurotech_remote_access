// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolePermission _$RolePermissionFromJson(Map<String, dynamic> json) =>
    RolePermission(
      id: json['id'] as String,
      scopeId: json['scopeId'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      createdBy: json['createdBy'] as String,
      roleId: json['roleId'] as String,
      permission: Permission.fromJson(
        json['permission'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RolePermissionToJson(RolePermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scopeId': instance.scopeId,
      'createdOn': instance.createdOn.toIso8601String(),
      'createdBy': instance.createdBy,
      'roleId': instance.roleId,
      'permission': instance.permission,
    };
