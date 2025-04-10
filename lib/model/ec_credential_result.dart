import 'package:json_annotation/json_annotation.dart';

part 'ec_credential_result.g.dart';

@JsonSerializable()
class EcCredentialResult {
  EcCredentialResult({
    required this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    this.optlock,
    this.credentialKey,
    required this.credentialType,
    this.expirationDate,
    required this.loginFailures,
    required this.status,
    required this.userId,
  });

  String type = 'credential';
  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  int? optlock;
  String? credentialKey;
  String credentialType;
  DateTime? expirationDate;
  int loginFailures = 0;
  String status;
  String userId;

  factory EcCredentialResult.fromJson(Map<String, dynamic> json) =>
      _$EcCredentialResultFromJson(json);
  Map<String, dynamic> toJson() => _$EcCredentialResultToJson(this);
}
