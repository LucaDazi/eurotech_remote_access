// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcTags _$EcTagsFromJson(Map<String, dynamic> json) => EcTags(
  items:
      (json['items'] as List<dynamic>)
          .map((e) => EcTag.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$EcTagsToJson(EcTags instance) => <String, dynamic>{
  'items': instance.items,
};
