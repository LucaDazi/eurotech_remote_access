// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_configurations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcConfigurations _$EcConfigurationsFromJson(Map<String, dynamic> json) =>
    EcConfigurations(
      type: json['type'] as String,
      configuration:
          (json['configuration'] as List<dynamic>)
              .map((e) => EcConfiguration.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EcConfigurationsToJson(EcConfigurations instance) =>
    <String, dynamic>{
      'type': instance.type,
      'configuration': instance.configuration,
    };
