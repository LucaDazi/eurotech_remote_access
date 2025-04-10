import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_role.dart';

part 'ec_roles_result.g.dart';

@JsonSerializable()
class EcRolesResult {
  EcRolesResult({
    required this.type,
    this.limitExceeded,
    this.size,
    this.items,
  });

  String type = 'roleListResult';
  bool? limitExceeded;
  int? size;
  List<EcRole>? items;
  factory EcRolesResult.fromJson(Map<String, dynamic> json) =>
      _$EcRolesResultFromJson(json);
  Map<String, dynamic> toJson() => _$EcRolesResultToJson(this);
}
