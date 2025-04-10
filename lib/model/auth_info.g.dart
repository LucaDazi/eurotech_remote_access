// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) => AuthInfo(
  type: json['type'] as String,
  accessToken: AuthResponse.fromJson(
    json['accessToken'] as Map<String, dynamic>,
  ),
  rolePermission:
      (json['rolePermission'] as List<dynamic>)
          .map((e) => RolePermission.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
  'type': instance.type,
  'accessToken': instance.accessToken,
  'rolePermission': instance.rolePermission,
};
