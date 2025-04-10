import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/permission.dart';

part 'role_permission.g.dart';

@JsonSerializable()
class RolePermission {
  RolePermission({
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.roleId,
    required this.permission,
  });

  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  String roleId;
  Permission permission;

  factory RolePermission.fromJson(Map<String, dynamic> json) =>
      _$RolePermissionFromJson(json);
  Map<String, dynamic> toJson() => _$RolePermissionToJson(this);
}
