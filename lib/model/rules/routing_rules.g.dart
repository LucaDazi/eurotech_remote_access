// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routing_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutingRules _$RoutingRulesFromJson(Map<String, dynamic> json) => RoutingRules(
  rules:
      (json['rules'] as List<dynamic>)
          .map((e) => RoutingRule.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$RoutingRulesToJson(RoutingRules instance) =>
    <String, dynamic>{'rules': instance.rules};
