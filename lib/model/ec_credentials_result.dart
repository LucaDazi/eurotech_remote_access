import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_credential_result.dart';

part 'ec_credentials_result.g.dart';

@JsonSerializable()
class EcCredentialsResult {
  EcCredentialsResult({
    required this.type,
    this.limitExceeded,
    this.size,
    this.items,
  });

  String type = 'credentialListResult';
  bool? limitExceeded;
  int? size;
  List<EcCredentialResult>? items;

  factory EcCredentialsResult.fromJson(Map<String, dynamic> json) =>
      _$EcCredentialsResultFromJson(json);
  Map<String, dynamic> toJson() => _$EcCredentialsResultToJson(this);
}
