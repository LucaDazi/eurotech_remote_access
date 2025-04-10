import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/auth_response.dart';
import 'package:remote_access/model/role_permission.dart';

part 'auth_info.g.dart';

@JsonSerializable()
class AuthInfo {
  AuthInfo({
    required this.type,
    required this.accessToken,
    required this.rolePermission,
  });

  String type;
  AuthResponse accessToken;
  List<RolePermission> rolePermission;

  factory AuthInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthInfoToJson(this);
}
