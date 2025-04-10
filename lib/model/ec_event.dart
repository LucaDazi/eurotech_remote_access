import 'package:json_annotation/json_annotation.dart';

part 'ec_event.g.dart';

@JsonSerializable()
class EcEvent {
  EcEvent({
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.deviceId,
    this.sentOn,
    this.receivedOn,
    required this.resource,
    required this.action,
    required this.responseCode,
  });

  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  String deviceId;
  DateTime? sentOn;
  DateTime? receivedOn;
  String resource;
  String action;
  String responseCode;

  factory EcEvent.fromJson(Map<String, dynamic> json) =>
      _$EcEventFromJson(json);
  Map<String, dynamic> toJson() => _$EcEventToJson(this);
}
