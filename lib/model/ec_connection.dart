import 'package:json_annotation/json_annotation.dart';

part 'ec_connection.g.dart';

@JsonSerializable()
class EcConnection {
  EcConnection({
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    this.optlock,
    this.allowUserChange,
    this.authenticationType,
    this.clientId,
    this.clientIp,
    this.lastAuthenticationType,
    this.protocol,
    this.reservedUserId,
    this.serverIp,
    this.status,
    this.userCouplingMode,
    this.userId,
  });

  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  int? optlock;
  bool? allowUserChange;
  String? authenticationType;
  String? clientId;
  String? clientIp;
  String? lastAuthenticationType;
  String? protocol;
  String? reservedUserId;
  String? serverIp;
  String? status;
  String? userCouplingMode;
  String? userId;

  factory EcConnection.fromJson(Map<String, dynamic> json) =>
      _$EcConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$EcConnectionToJson(this);
}
