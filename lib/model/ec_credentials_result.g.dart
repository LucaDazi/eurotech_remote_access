// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_credentials_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcCredentialsResult _$EcCredentialsResultFromJson(Map<String, dynamic> json) =>
    EcCredentialsResult(
      type: json['type'] as String,
      limitExceeded: json['limitExceeded'] as bool?,
      size: (json['size'] as num?)?.toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => EcCredentialResult.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$EcCredentialsResultToJson(
  EcCredentialsResult instance,
) => <String, dynamic>{
  'type': instance.type,
  'limitExceeded': instance.limitExceeded,
  'size': instance.size,
  'items': instance.items,
};
