import 'package:remote_access/model/configuration/downstream_device.dart';
import 'package:remote_access/model/ec_account.dart';
import 'package:remote_access/model/ec_device.dart';

class RemoteAccessDevice {
  RemoteAccessDevice({
    required this.downstreamDevice,
    required this.device,
    required this.account,
  });

  DownstreamDevice downstreamDevice;
  EcDevice device;
  EcAccount account;
}
