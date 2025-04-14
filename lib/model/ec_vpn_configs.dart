import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_vpn_config.dart';

part 'ec_vpn_configs.g.dart';

@JsonSerializable()
class EcVpnConfigs {
  EcVpnConfigs({
    required this.limitExceeded,
    required this.size,
    required this.items,
  });

  bool limitExceeded;
  int size;
  List<EcVpnConfig> items;

  factory EcVpnConfigs.fromJson(Map<String, dynamic> json) =>
      _$EcVpnConfigsFromJson(json);
  Map<String, dynamic> toJson() => _$EcVpnConfigsToJson(this);
}
