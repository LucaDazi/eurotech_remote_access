import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/configuration/downstream_device.dart';

part 'downstream_devices.g.dart';

@JsonSerializable()
class DownstreamDevices {
  DownstreamDevices({required this.devices});

  List<DownstreamDevice> devices;

  factory DownstreamDevices.fromJson(Map<String, dynamic> json) =>
      _$DownstreamDevicesFromJson(json);
  Map<String, dynamic> toJson() => _$DownstreamDevicesToJson(this);
}
