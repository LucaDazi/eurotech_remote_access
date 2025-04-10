import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_device.dart';

part 'ec_devices_result.g.dart';

@JsonSerializable()
class EcDevicesResult {
  EcDevicesResult({
    required this.type,
    required this.limitExceeded,
    required this.size,
    required this.items,
  });

  String type;
  bool limitExceeded;
  int size;
  List<EcDevice> items;

  factory EcDevicesResult.fromJson(Map<String, dynamic> json) =>
      _$EcDevicesResultFromJson(json);
  Map<String, dynamic> toJson() => _$EcDevicesResultToJson(this);
}
