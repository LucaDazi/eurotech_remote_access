import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_user.dart';

part 'ec_users_response.g.dart';

@JsonSerializable()
class EcUsersResponse {
  EcUsersResponse({
    required this.type,
    required this.limitExceeded,
    required this.size,
    required this.items,
  });

  String type;
  bool limitExceeded;
  int size;
  List<EcUser> items;

  factory EcUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$EcUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EcUsersResponseToJson(this);
}
