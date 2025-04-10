// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcTag _$EcTagFromJson(Map<String, dynamic> json) => EcTag(
  id: json['id'] as String,
  name: json['name'] as String,
  optlock: (json['optlock'] as num?)?.toInt(),
  description: json['description'] as String,
);

Map<String, dynamic> _$EcTagToJson(EcTag instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'optlock': instance.optlock,
};
