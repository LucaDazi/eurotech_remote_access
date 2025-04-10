import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/rules/routing_rule.dart';

part 'routing_rules.g.dart';

@JsonSerializable()
class RoutingRules {
  RoutingRules({required this.rules});

  List<RoutingRule> rules;

  factory RoutingRules.fromJson(Map<String, dynamic> json) =>
      _$RoutingRulesFromJson(json);
  Map<String, dynamic> toJson() => _$RoutingRulesToJson(this);
}
