// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_devices_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcDevicesResult _$EcDevicesResultFromJson(Map<String, dynamic> json) =>
    EcDevicesResult(
      type: json['type'] as String,
      limitExceeded: json['limitExceeded'] as bool,
      size: (json['size'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>)
              .map((e) => EcDevice.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EcDevicesResultToJson(EcDevicesResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'limitExceeded': instance.limitExceeded,
      'size': instance.size,
      'items': instance.items,
    };
