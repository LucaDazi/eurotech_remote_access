// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) => UserUpdate(
  type: json['type'] as String,
  optlock: (json['optlock'] as num).toInt(),
  name: json['name'] as String,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  status: json['status'] as String,
  userType: json['userType'] as String,
);

Map<String, dynamic> _$UserUpdateToJson(UserUpdate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'optlock': instance.optlock,
      'name': instance.name,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'userType': instance.userType,
    };
