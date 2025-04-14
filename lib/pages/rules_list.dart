import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/ec_user.dart';
import 'package:remote_access/model/remote_access_device.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/services/api_service.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  RemoteAccessDevice raDropdownValue =
      getIt<ApiService>().getRemoteAccessDevices().first;
  EcUser userDropdownValue = getIt<ApiService>().getRemoteAccessUsers().first;

  final TextEditingController _filterController = TextEditingController();
  bool _isUpdating = false;
  final Set<int> _hoveredIndices = {}; // Track hovered indices

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.only(left: 16, right: 8, bottom: 8),
            child: DefaultTextStyle(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remote Access Rules management',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Subtitle'),
                    SizedBox(width: double.infinity),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Downstream Devices',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: double.infinity),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              RemoteAccessDevice rad =
                                  getIt<ApiService>()
                                      .getRemoteAccessDevices()[index];
                              return ListTile(
                                title: Text(
                                  '${rad.downstreamDevice.name} (${rad.downstreamDevice.namespace})',
                                ),
                                subtitle: Text(
                                  '${rad.account.name}/${rad.device.displayName}',
                                ),
                              );
                            },
                            itemCount:
                                getIt<ApiService>()
                                    .getRemoteAccessDevices()
                                    .length,
                            shrinkWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Remote Users',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: double.infinity),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              EcUser rau =
                                  getIt<ApiService>()
                                      .getRemoteAccessUsers()[index];
                              return ListTile(
                                title: Text(rau.displayName!),
                                subtitle: Text(rau.email!),
                              );
                            },
                            itemCount:
                                getIt<ApiService>()
                                    .getRemoteAccessUsers()
                                    .length,
                            shrinkWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Currently available remote access rules'),
                        SizedBox(width: 32.0),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await _createNewRule();
                          },
                          icon: Icon(Icons.add),
                          label: Text('Create new rule'),
                        ),
                        SizedBox(width: 32.0),
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              _isUpdating = true;
                            });
                            await getIt<ApiService>().getRoutingRules(true);
                            setState(() {
                              _isUpdating = false;
                            });
                          },
                          icon: Icon(Icons.refresh),
                          label: Text('Refresh'),
                        ),
                        Expanded(child: Container()),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextField(
                            controller: _filterController,
                            onChanged: (value) {
                              setState(() {}); // Implement filter logic here
                            },
                            decoration: InputDecoration(
                              hintText: 'Filter',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: double.infinity),
                    FutureBuilder<List<RoutingRule>>(
                      future: getIt<ApiService>().getRoutingRules(false),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || _isUpdating) {
                          return CircularProgressIndicator();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            RoutingRule rr = snapshot.data![index];
                            final isHovered = _hoveredIndices.contains(index);
                            String accountName =
                                rr.account != null
                                    ? rr.account!.name
                                    : rr.accountId;
                            String deviceId =
                                rr.device != null
                                    ? (rr.device!.displayName != null
                                        ? rr.device!.displayName!
                                        : rr.device!.clientId)
                                    : rr.deviceId;
                            return Card(
                              elevation: 8.0,
                              child: MouseRegion(
                                onEnter: (event) {
                                  setState(() {
                                    _hoveredIndices.add(index);
                                  });
                                },
                                onExit: (event) {
                                  setState(() {
                                    _hoveredIndices.remove(index);
                                  });
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '$accountName/$deviceId/${rr.downstreamDeviceName} (${rr.downstreamDeviceIp})',
                                      ),
                                      subtitle: Text(
                                        rr.user != null
                                            ? '${rr.user!.name.replaceFirst('RA_', '')} (${rr.user!.displayName} - ${rr.user!.email})'
                                            : rr.userId,
                                      ),
                                      leading: Switch(
                                        value: rr.enabled,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    if (isHovered)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                setState(() {
                                                  rr.enabled = !rr.enabled;
                                                });
                                                await getIt<ApiService>()
                                                    .putRoutingRules(
                                                      snapshot.data!,
                                                    );
                                              },
                                              label:
                                                  _isUpdating
                                                      ? CircularProgressIndicator()
                                                      : Icon(Icons.toggle_on),
                                            ),
                                            SizedBox(width: 8.0),
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                snapshot.data!.remove(rr);
                                                await getIt<ApiService>()
                                                    .putRoutingRules(
                                                      snapshot.data!,
                                                    );
                                                setState(() {});
                                              },
                                              label:
                                                  _isUpdating
                                                      ? CircularProgressIndicator()
                                                      : Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _getNewRulePanel(void Function(void Function()) setState) {
    return Row(
      children: [
        DropdownButton<EcUser>(
          value: userDropdownValue,
          items:
              getIt<ApiService>().getRemoteAccessUsers().map((e) {
                return DropdownMenuItem<EcUser>(
                  value: e,
                  child: Text(
                    e.displayName != null ? e.displayName! : 'UNKNOWN',
                  ),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              userDropdownValue = value!;
            });
          },
        ),
        SizedBox(width: 32.0),
        Text('permitted to connect to'),
        SizedBox(width: 32.0),
        DropdownButton<RemoteAccessDevice>(
          value: raDropdownValue,
          items:
              getIt<ApiService>().getRemoteAccessDevices().map((e) {
                return DropdownMenuItem<RemoteAccessDevice>(
                  value: e,
                  child: Text(e.downstreamDevice.name),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              raDropdownValue = value!;
            });
          },
        ),
      ],
    );
  }

  Future<void> _createNewRule() async {
    RoutingRule? result = await _showInformationDialog(context);
    setState(() {
      _isUpdating = true;
    });
    final routingRules = await getIt<ApiService>().getRoutingRules(true);
    if (result != null) {
      routingRules.add(result);
      await getIt<ApiService>().putRoutingRules(routingRules);
    }
    setState(() {
      _isUpdating = false;
    });
  }

  Future<RoutingRule?> _showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(child: _getNewRulePanel(setState)),
              title: Text('New Remote Access Rule'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () async {
                    RoutingRule rr = RoutingRule(
                      enabled: false,
                      userId: userDropdownValue.id,
                      accountId: raDropdownValue.account.id,
                      deviceId: raDropdownValue.device.id,
                      user: userDropdownValue,
                      device: raDropdownValue.device,
                      account: raDropdownValue.account,
                      downstreamDeviceName:
                          raDropdownValue.downstreamDevice.name,
                      downstreamDeviceIp: raDropdownValue.downstreamDevice.iPv4,
                      namespace: raDropdownValue.downstreamDevice.namespace!,
                    );
                    Navigator.of(context).pop(rr);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
