import 'package:json_annotation/json_annotation.dart';

part 'ec_create_credential.g.dart';

@JsonSerializable()
class EcCreateCredential {
  EcCreateCredential({
    required this.userId,
    required this.credentialType,
    this.credentialKey,
    required this.credentialStatus,
    required this.expirationDate,
  });

  String userId;
  String credentialType;
  String? credentialKey;
  String credentialStatus;
  DateTime expirationDate;

  factory EcCreateCredential.fromJson(Map<String, dynamic> json) =>
      _$EcCreateCredentialFromJson(json);
  Map<String, dynamic> toJson() => _$EcCreateCredentialToJson(this);
}
