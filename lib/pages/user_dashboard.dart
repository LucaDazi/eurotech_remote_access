import 'package:flutter/material.dart';
import 'package:remote_access/pages/admin_dashboard.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/pages/remote_devices_list.dart';

import 'package:remote_access/pages/settings.dart';

const List<DashboardDestinations> destinations = <DashboardDestinations>[
  DashboardDestinations(
    'Remote Devices',
    Icon(Icons.router_outlined),
    Icon(Icons.router),
  ),
  DashboardDestinations(
    'Settings',
    Icon(Icons.settings_outlined),
    Icon(Icons.settings),
  ),
];

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void handleScreenChanged(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: NavigationRail(
                minWidth: 100,
                labelType: NavigationRailLabelType.all,
                leading: Image(
                  image: AssetImage('assets/images/logo1.png'),
                  height: 50,
                ),
                destinations:
                    destinations.map((DashboardDestinations destination) {
                      return NavigationRailDestination(
                        label: Text(destination.label),
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        indicatorShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      );
                    }).toList(),
                selectedIndex: screenIndex,
                useIndicator: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    screenIndex = index;
                  });
                },
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(children: [Text('Remote Access UI')]),
                  ),
                  _buildDestinationWidget(screenIndex),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map((DashboardDestinations destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationWidget(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return RemoteDevicesPage();
      case 1:
        return SettingsPage();
      default:
        return Text('Current page: $screenIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawerScaffold(context);
  }
}
