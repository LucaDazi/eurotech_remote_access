// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_accounts_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcAccountsResult _$EcAccountsResultFromJson(Map<String, dynamic> json) =>
    EcAccountsResult(
      type: json['type'] as String,
      limitExceeded: json['limitExceeded'] as bool,
      size: (json['size'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>)
              .map((e) => EcAccount.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EcAccountsResultToJson(EcAccountsResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'limitExceeded': instance.limitExceeded,
      'size': instance.size,
      'items': instance.items,
    };
