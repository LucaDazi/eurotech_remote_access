import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/services/api_service.dart';

class RemoteDevicesPage extends StatefulWidget {
  const RemoteDevicesPage({super.key});

  @override
  State<RemoteDevicesPage> createState() => _RemoteDevicesPageState();
}

class _RemoteDevicesPageState extends State<RemoteDevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Title'),
                      subtitle: Text('Subtitle'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FilledButton(
                        onPressed: () async {
                          final rrs =
                              await getIt<ApiService>()
                                  .getFilteredRoutingRules();
                          for (RoutingRule rr in rrs) {
                            debugPrint(
                              'Routing Rule: ${rr.userId} to ${rr.namespace}/${rr.downstreamDeviceName} (${rr.downstreamDeviceIp})',
                            );
                          }
                        },
                        child: Text('Load rules'),
                      ),
                      SizedBox(width: 16.0),
                      FilledButton(
                        onPressed: () async {
                          final rrs =
                              await getIt<ApiService>()
                                  .getFilteredRoutingRules();
                          await getIt<ApiService>().tunVpnConnect(
                            rrs.first.accountId,
                            rrs.first.deviceId,
                          );
                        },
                        child: Text('VPN Connect'),
                      ),
                      SizedBox(width: 16.0),
                      FilledButton(
                        onPressed: () async {
                          final rrs =
                              await getIt<ApiService>()
                                  .getFilteredRoutingRules();
                          await getIt<ApiService>().tunVpnDisconnect(
                            rrs.first.accountId,
                            rrs.first.deviceId,
                          );
                        },
                        child: Text('VPN Disconnect'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
