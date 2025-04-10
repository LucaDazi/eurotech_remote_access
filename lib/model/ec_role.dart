import 'package:json_annotation/json_annotation.dart';

part 'ec_role.g.dart';

@JsonSerializable()
class EcRole {
  EcRole({
    this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    this.optlock,
    required this.name,
  });

  String? type;
  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  int? optlock;
  String name;

  factory EcRole.fromJson(Map<String, dynamic> json) => _$EcRoleFromJson(json);
  Map<String, dynamic> toJson() => _$EcRoleToJson(this);
}
