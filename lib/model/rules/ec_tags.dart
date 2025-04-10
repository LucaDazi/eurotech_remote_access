import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/rules/ec_tag.dart';

part 'ec_tags.g.dart';

@JsonSerializable()
class EcTags {
  EcTags({required this.items});

  List<EcTag> items;

  factory EcTags.fromJson(Map<String, dynamic> json) => _$EcTagsFromJson(json);
  Map<String, dynamic> toJson() => _$EcTagsToJson(this);
}
