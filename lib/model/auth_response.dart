import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  AuthResponse({
    this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    this.optLock,
    required this.tokenId,
    required this.userId,
    required this.expiresOn,
    required this.refreshToken,
    required this.refreshExpiresOn,
  });

  String? type;
  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  int? optLock;
  String tokenId;
  String userId;
  DateTime expiresOn;
  String refreshToken;
  DateTime refreshExpiresOn;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
