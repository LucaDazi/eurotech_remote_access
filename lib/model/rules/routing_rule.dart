import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_account.dart';
import 'package:remote_access/model/ec_device.dart';
import 'package:remote_access/model/ec_user.dart';

part 'routing_rule.g.dart';

@JsonSerializable()
class RoutingRule {
  RoutingRule({
    required this.enabled,
    required this.userId,
    required this.accountId,
    required this.deviceId,
    required this.downstreamDeviceName,
    required this.downstreamDeviceIp,
    this.account,
    this.device,
    this.user,
  });

  bool enabled;
  String userId;
  String accountId;
  String deviceId;
  String downstreamDeviceName;
  String downstreamDeviceIp;
  @JsonKey(includeFromJson: false, includeToJson: false)
  EcDevice? device;
  @JsonKey(includeFromJson: false, includeToJson: false)
  EcAccount? account;
  @JsonKey(includeFromJson: false, includeToJson: false)
  EcUser? user;

  factory RoutingRule.fromJson(Map<String, dynamic> json) =>
      _$RoutingRuleFromJson(json);
  Map<String, dynamic> toJson() => _$RoutingRuleToJson(this);
}
