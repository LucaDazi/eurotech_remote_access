import 'package:json_annotation/json_annotation.dart';

part 'ec_instance.g.dart';

@JsonSerializable()
class EcInstance {
  EcInstance({
    required this.consoleEndpoint,
    required this.country,
    required this.friendlyName,
    required this.id,
    required this.provisionEndpoint,
    required this.region,
    required this.subRegion,
    required this.type,
    this.apiEndpoint,
  });

  @JsonKey(name: 'console_endpoint')
  String consoleEndpoint;
  String country;
  @JsonKey(name: 'friendly_name')
  String friendlyName;
  String id;
  @JsonKey(name: 'provision_endpoint')
  String provisionEndpoint;
  String region;
  @JsonKey(name: 'sub_region')
  String subRegion;
  String type;
  @JsonKey(includeFromJson: true)
  String? apiEndpoint;

  factory EcInstance.fromJson(Map<String, dynamic> json) {
    EcInstance result = _$EcInstanceFromJson(json);
    if (result.id == 'sbx') {
      result.apiEndpoint = 'api-sbx.everyware.io';
    } else {
      result.apiEndpoint = 'api.${result.id}.everyware.io';
    }
    return result;
  }
  Map<String, dynamic> toJson() => _$EcInstanceToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EcInstance &&
          runtimeType == other.runtimeType &&
          consoleEndpoint == other.consoleEndpoint &&
          country == other.country &&
          friendlyName == other.friendlyName &&
          id == other.id &&
          provisionEndpoint == other.provisionEndpoint &&
          region == other.region &&
          subRegion == other.subRegion &&
          type == other.type &&
          apiEndpoint == other.apiEndpoint;

  @override
  int get hashCode =>
      consoleEndpoint.hashCode ^
      country.hashCode ^
      friendlyName.hashCode ^
      id.hashCode ^
      provisionEndpoint.hashCode ^
      region.hashCode ^
      subRegion.hashCode ^
      type.hashCode ^
      apiEndpoint.hashCode;
}
