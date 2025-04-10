import 'package:json_annotation/json_annotation.dart';

part 'downstream_device.g.dart';

@JsonSerializable()
class DownstreamDevice {
  DownstreamDevice({
    required this.name,
    required this.type,
    required this.iPv4,
    this.namespace,
  });

  String name;
  String type;
  @JsonKey(name: 'IPv4')
  String iPv4;
  String? namespace = '/';

  factory DownstreamDevice.fromJson(Map<String, dynamic> json) =>
      _$DownstreamDeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DownstreamDeviceToJson(this);
}
