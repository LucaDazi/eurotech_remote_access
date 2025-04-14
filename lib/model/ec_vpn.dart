import 'package:json_annotation/json_annotation.dart';

part 'ec_vpn.g.dart';

@JsonSerializable()
class EcVpn {
  EcVpn({required this.connected, required this.ipAddress});

  bool connected;
  String ipAddress;

  factory EcVpn.fromJson(Map<String, dynamic> json) => _$EcVpnFromJson(json);
  Map<String, dynamic> toJson() => _$EcVpnToJson(this);
}
