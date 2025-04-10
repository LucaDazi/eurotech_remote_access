import 'package:json_annotation/json_annotation.dart';
part 'access_info.g.dart';

@JsonSerializable()
class AccessInfo {
  AccessInfo({required this.userId, required this.roleIds});
  String userId;
  List<String> roleIds;
  factory AccessInfo.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AccessInfoToJson(this);
}
