// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
  property:
      (json['property'] as List<dynamic>)
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{'property': instance.property};
