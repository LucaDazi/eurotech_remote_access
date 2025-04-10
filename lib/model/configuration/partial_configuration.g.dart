// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcConfiguration _$EcConfigurationFromJson(Map<String, dynamic> json) =>
    EcConfiguration(
      id: json['id'] as String,
      properties: Properties.fromJson(
        json['properties'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$EcConfigurationToJson(EcConfiguration instance) =>
    <String, dynamic>{'id': instance.id, 'properties': instance.properties};
