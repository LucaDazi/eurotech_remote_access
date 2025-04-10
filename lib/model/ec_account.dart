import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_organization.dart';

part 'ec_account.g.dart';

@JsonSerializable()
class EcAccount {
  EcAccount({
    required this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.name,
    this.optlock,
    required this.organization,
    required this.parentAccountPath,
    this.visibleInUi,
  });

  String type;
  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  String name;
  int? optlock;
  EcOrganization organization;
  String parentAccountPath;
  bool? visibleInUi = true;

  factory EcAccount.fromJson(Map<String, dynamic> json) =>
      _$EcAccountFromJson(json);
  Map<String, dynamic> toJson() => _$EcAccountToJson(this);
}
