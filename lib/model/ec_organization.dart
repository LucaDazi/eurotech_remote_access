import 'package:json_annotation/json_annotation.dart';

part 'ec_organization.g.dart';

@JsonSerializable()
class EcOrganization {
  EcOrganization({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.country,
    required this.email,
    required this.name,
    this.personName,
    this.phoneNumber,
    this.stateProvinceCounty,
    this.zipPostCode,
  });

  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? country;
  String email;
  String name;
  String? personName;
  String? phoneNumber;
  String? stateProvinceCounty;
  String? zipPostCode;

  factory EcOrganization.fromJson(Map<String, dynamic> json) =>
      _$EcOrganizationFromJson(json);
  Map<String, dynamic> toJson() => _$EcOrganizationToJson(this);
}
