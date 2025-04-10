import 'package:json_annotation/json_annotation.dart';

part 'permission.g.dart';

@JsonSerializable()
class Permission {
  Permission({
    this.domain,
    this.action,
    required this.targetScopeId,
    required this.forwardable,
  });

  String? domain;
  String? action;
  String targetScopeId;
  bool forwardable;

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}
