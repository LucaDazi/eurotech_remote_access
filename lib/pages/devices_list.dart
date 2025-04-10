import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/ec_account.dart';
import 'package:remote_access/model/ec_device.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/widgets/center_card.dart';
import 'package:remote_access/widgets/geographic_device_tree.dart';
import 'package:remote_access/widgets/logical_device_tree.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  TreeViewController? treeViewController;
  final TextEditingController _filterController = TextEditingController();
  bool forceRefresh = false;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                    'Remote Access Devices management',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Subtitle'),
                  SizedBox(width: double.infinity),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: 8, bottom: 8),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text('Currently available devices'),
                          SizedBox(width: 32.0),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                forceRefresh = true;
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
                      SizedBox(height: 16.0, width: double.infinity),
                      FutureBuilder(
                        future: getIt<ApiService>().getDeviceTree(forceRefresh),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return CenterCard(
                              label: 'Error: ${snapshot.error}',
                            );
                          } else if (!snapshot.hasData) {
                            return CenterCard(
                              label: 'No child accounts found.',
                            );
                          } else {
                            forceRefresh = false;
                            final deviceTree = snapshot.data!;
                            debugPrint('About to filter...');

                            _iterateDeviceVisibility(deviceTree.children);
                            _iterateAccountVisibility(deviceTree.children);

                            return DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: [
                                      Tab(text: 'Logical tree'),
                                      Tab(text: 'Geographic tree'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight - 128,
                                    child: TabBarView(
                                      children: [
                                        LogicalDeviceTree(
                                          deviceTree: deviceTree,
                                        ),
                                        GeographicDeviceTree(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _iterateDeviceVisibility(Map<String, Node> nodeMap) {
    for (var element in nodeMap.entries) {
      var node = element.value as TreeNode;
      if (node.data is EcDevice) {
        EcDevice d = node.data as EcDevice;
        d.visibleInUi =
            (d.clientId.contains(_filterController.text.trim())) ||
            (d.displayName!.contains(_filterController.text.trim()));
      }
      if (node.data is EcAccount) {
        _iterateDeviceVisibility(node.children);
      }
    }
  }

  void _iterateAccountVisibility(Map<String, Node> nodeMap) {
    for (var element in nodeMap.entries) {
      var node = element.value as TreeNode;
      if (node.data is EcAccount) {
        bool atLeastOneVisible = false;
        for (var deviceNode in node.children.entries) {
          var deviceNodeTree = deviceNode.value as TreeNode;
          if (deviceNodeTree.data is EcDevice) {
            if ((deviceNodeTree.data as EcDevice).visibleInUi!) {
              atLeastOneVisible = true;
              break;
            }
          }
        }
        (node.data as EcAccount).visibleInUi = atLeastOneVisible;
      }
    }
  }
}
