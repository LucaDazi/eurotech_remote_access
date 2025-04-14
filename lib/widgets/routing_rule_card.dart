import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/ec_vpn.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/services/vpn_service.dart';

class RoutingRuleCard extends StatefulWidget {
  const RoutingRuleCard({super.key, required this.routingRule});

  final RoutingRule routingRule;

  @override
  State<RoutingRuleCard> createState() => _RoutingRuleCardState();
}

class _RoutingRuleCardState extends State<RoutingRuleCard> {
  bool _isWorking = false;
  EcVpn _connectionStatus = EcVpn(connected: false, ipAddress: '0.0.0.0');
  final ScrollController _scrollController = ScrollController();
  String _terminalOutput = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            enabled: widget.routingRule.enabled,
            title: Text(
              '${widget.routingRule.downstreamDeviceName} (${widget.routingRule.downstreamDeviceIp})',
            ),
            subtitle: Text(widget.routingRule.namespace),
            trailing: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _connectionStatus.connected
                          ? 'connected to VPN'
                          : 'Not connected to VPN',
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      _connectionStatus.connected
                          ? Icons.cloud_outlined
                          : Icons.cloud_off,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed:
                      _isWorking
                          ? null
                          : widget.routingRule.enabled
                          ? () async {
                            setState(() {
                              _isWorking = true;
                            });
                            if (_connectionStatus.connected) {
                              await _disconnectFromVpn(context);
                            } else {
                              await _connectToVpn(context);
                            }
                            setState(() {
                              _isWorking = false;
                            });
                          }
                          : null,
                  child: Text(
                    _connectionStatus.connected
                        ? 'Disconnect'
                        : 'Connect to ${widget.routingRule.downstreamDeviceName}',
                  ),
                ),
                if (_isWorking) CircularProgressIndicator(),
              ],
            ),
          ),
          if (_connectionStatus.connected)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: StreamBuilder<Object>(
                stream: getIt<VpnService>().openVpnStdout,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _terminalOutput += '\n${snapshot.data!}';
                    _scrollToBottom();
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                        minWidth: double.infinity,
                      ),
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Container(
                            color: Colors.black,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _terminalOutput,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14.0,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _disconnectFromVpn(BuildContext context) async {
    try {
      await getIt<ApiService>().tunVpnDisconnect(
        widget.routingRule.accountId,
        widget.routingRule.deviceId,
      );
      _connectionStatus = EcVpn(connected: false, ipAddress: '0.0.0.0');

      await getIt<VpnService>().terminateVpnConnection();
      setState(() {
        _terminalOutput = '';
      });
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Unable to disconnect from VPN:\r$e'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> _connectToVpn(BuildContext context) async {
    try {
      final vpnStatus = await getIt<ApiService>().tunVpnConnect(
        widget.routingRule.accountId,
        widget.routingRule.deviceId,
      );
      _connectionStatus = vpnStatus;

      await getIt<VpnService>().initiateVpnConnection(
        widget.routingRule,
        getIt<ApiService>().cachedUser,
        getIt<ApiService>().cachedPassword,
      );
    } catch (e) {
      final snackBar = SnackBar(content: Text('Unable to connect to VPN:\r$e'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }
}
