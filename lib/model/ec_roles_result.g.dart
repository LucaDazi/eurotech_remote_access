// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_roles_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcRolesResult _$EcRolesResultFromJson(Map<String, dynamic> json) =>
    EcRolesResult(
      type: json['type'] as String,
      limitExceeded: json['limitExceeded'] as bool?,
      size: (json['size'] as num?)?.toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => EcRole.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EcRolesResultToJson(EcRolesResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'limitExceeded': instance.limitExceeded,
      'size': instance.size,
      'items': instance.items,
    };
