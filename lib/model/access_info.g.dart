// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessInfo _$AccessInfoFromJson(Map<String, dynamic> json) => AccessInfo(
  userId: json['userId'] as String,
  roleIds: (json['roleIds'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$AccessInfoToJson(AccessInfo instance) =>
    <String, dynamic>{'userId': instance.userId, 'roleIds': instance.roleIds};
