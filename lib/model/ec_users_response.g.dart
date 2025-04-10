// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_users_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcUsersResponse _$EcUsersResponseFromJson(Map<String, dynamic> json) =>
    EcUsersResponse(
      type: json['type'] as String,
      limitExceeded: json['limitExceeded'] as bool,
      size: (json['size'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>)
              .map((e) => EcUser.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EcUsersResponseToJson(EcUsersResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'limitExceeded': instance.limitExceeded,
      'size': instance.size,
      'items': instance.items,
    };
