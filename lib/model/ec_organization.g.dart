// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec_organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcOrganization _$EcOrganizationFromJson(Map<String, dynamic> json) =>
    EcOrganization(
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      addressLine3: json['addressLine3'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      personName: json['personName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      stateProvinceCounty: json['stateProvinceCounty'] as String?,
      zipPostCode: json['zipPostCode'] as String?,
    );

Map<String, dynamic> _$EcOrganizationToJson(EcOrganization instance) =>
    <String, dynamic>{
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressLine3': instance.addressLine3,
      'city': instance.city,
      'country': instance.country,
      'email': instance.email,
      'name': instance.name,
      'personName': instance.personName,
      'phoneNumber': instance.phoneNumber,
      'stateProvinceCounty': instance.stateProvinceCounty,
      'zipPostCode': instance.zipPostCode,
    };
