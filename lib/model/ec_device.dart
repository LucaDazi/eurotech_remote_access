import 'package:json_annotation/json_annotation.dart';
import 'package:remote_access/model/ec_connection.dart';
import 'package:remote_access/model/ec_event.dart';
import 'package:remote_access/model/ec_extended_property.dart';

part 'ec_device.g.dart';

@JsonSerializable()
class EcDevice {
  EcDevice({
    required this.type,
    required this.id,
    required this.scopeId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    this.optlock,
    required this.clientId,
    this.connectionId,
    this.connection,
    this.status,
    this.displayName,
    this.lastEventId,
    this.lastEvent,
    this.serialNumber,
    this.modelId,
    this.modelName,
    this.biosVersion,
    this.firmwareVersion,
    this.osVersion,
    this.jvmVersion,
    this.osgiFrameworkVersion,
    this.applicationFrameworkVersion,
    this.connectionInterface,
    this.connectionIp,
    this.applicationIdentifiers,
    this.acceptEncoding,
    this.customAttribute1,
    this.customAttribute2,
    this.customAttribute3,
    this.customAttribute4,
    this.extendedProperties,
    required this.tagIds,
    this.visibleInUi,
  });

  String type;
  String id;
  String scopeId;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  int? optlock;
  String clientId;
  String? connectionId;
  EcConnection? connection;
  String? status;
  String? displayName;
  String? lastEventId;
  EcEvent? lastEvent;
  String? serialNumber;
  String? modelId;
  String? modelName;
  String? biosVersion;
  String? firmwareVersion;
  String? osVersion;
  String? jvmVersion;
  String? osgiFrameworkVersion;
  String? applicationFrameworkVersion;
  String? connectionInterface;
  String? connectionIp;
  String? applicationIdentifiers;
  String? acceptEncoding;
  String? customAttribute1;
  String? customAttribute2;
  String? customAttribute3;
  String? customAttribute4;
  List<EcExtendedProperty>? extendedProperties;
  List<String> tagIds;
  bool? visibleInUi = true;

  factory EcDevice.fromJson(Map<String, dynamic> json) =>
      _$EcDeviceFromJson(json);
  Map<String, dynamic> toJson() => _$EcDeviceToJson(this);
}
