import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_account.dart';

part 'ec_accounts_result.g.dart';

@JsonSerializable()
class EcAccountsResult {
  EcAccountsResult({
    required this.type,
    required this.limitExceeded,
    required this.size,
    required this.items,
  });

  String type;
  bool limitExceeded;
  int size;
  List<EcAccount> items;

  factory EcAccountsResult.fromJson(Map<String, dynamic> json) =>
      _$EcAccountsResultFromJson(json);
  Map<String, dynamic> toJson() => _$EcAccountsResultToJson(this);
}
