import 'package:json_annotation/json_annotation.dart';

part 'user_update.g.dart';

@JsonSerializable()
class UserUpdate {
  UserUpdate({
    required this.type,
    required this.optlock,
    required this.name,
    this.displayName,
    this.email,
    this.phoneNumber,
    required this.status,
    required this.userType,
  });

  String type = 'user';
  int optlock = 0;
  String name;
  String? displayName;
  String? email;
  String? phoneNumber;
  String status = 'ENABLED';
  String userType = 'INTERNAL';

  factory UserUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateToJson(this);
}
