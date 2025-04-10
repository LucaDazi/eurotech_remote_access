import 'package:json_annotation/json_annotation.dart';

part 'ec_user.g.dart';

@JsonSerializable()
class EcUser {
  EcUser({
    this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    this.optlock,
    required this.name,
    this.displayName,
    this.email,
    this.expirationDate,
    required this.status,
    required this.userType,
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
  String? displayName;
  String? email;
  DateTime? expirationDate;
  String status;
  String userType;

  factory EcUser.fromJson(Map<String, dynamic> json) => _$EcUserFromJson(json);
  Map<String, dynamic> toJson() => _$EcUserToJson(this);

  EcUser copyWith({
    String? type,
    String? id,
    String? scopeId,
    DateTime? createdOn,
    String? createdBy,
    DateTime? modifiedOn,
    String? modifiedBy,
    int? optlock,
    String? name,
    String? displayName,
    String? email,
    DateTime? expirationDate,
    String? status,
    String? userType,
  }) {
    return EcUser(
      type: type ?? this.type,
      id: id ?? this.id,
      scopeId: scopeId ?? this.scopeId,
      createdOn: createdOn ?? this.createdOn,
      createdBy: createdBy ?? this.createdBy,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      optlock: optlock ?? this.optlock,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      expirationDate: expirationDate ?? this.expirationDate,
      status: status ?? this.status,
      userType: userType ?? this.userType,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EcUser &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          id == other.id &&
          scopeId == other.scopeId &&
          createdOn == other.createdOn &&
          createdBy == other.createdBy &&
          modifiedOn == other.modifiedOn &&
          modifiedBy == other.modifiedBy &&
          optlock == other.optlock &&
          name == other.name &&
          displayName == other.displayName &&
          email == other.email &&
          expirationDate == other.expirationDate &&
          status == other.status &&
          userType == other.userType;

  @override
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      scopeId.hashCode ^
      createdOn.hashCode ^
      createdBy.hashCode ^
      modifiedOn.hashCode ^
      modifiedBy.hashCode ^
      optlock.hashCode ^
      name.hashCode ^
      displayName.hashCode ^
      email.hashCode ^
      expirationDate.hashCode ^
      status.hashCode ^
      userType.hashCode;
}
