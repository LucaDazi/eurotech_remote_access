// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
  name: json['name'] as String,
  array: json['array'] as bool,
  encrypted: json['encrypted'] as bool,
  type: json['type'] as String,
  value: (json['value'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
  'name': instance.name,
  'array': instance.array,
  'encrypted': instance.encrypted,
  'type': instance.type,
  'value': instance.value,
};
