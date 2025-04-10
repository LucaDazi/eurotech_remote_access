// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) => Ad(
  cardinality: (json['cardinality'] as num).toInt(),
  description: json['description'] as String,
  id: json['id'] as String,
  name: json['name'] as String,
  required: json['required'] as bool,
  type: json['type'] as String,
);

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
  'cardinality': instance.cardinality,
  'description': instance.description,
  'id': instance.id,
  'name': instance.name,
  'required': instance.required,
  'type': instance.type,
};
