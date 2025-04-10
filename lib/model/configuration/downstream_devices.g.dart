// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downstream_devices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownstreamDevices _$DownstreamDevicesFromJson(Map<String, dynamic> json) =>
    DownstreamDevices(
      devices:
          (json['devices'] as List<dynamic>)
              .map((e) => DownstreamDevice.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DownstreamDevicesToJson(DownstreamDevices instance) =>
    <String, dynamic>{'devices': instance.devices};
