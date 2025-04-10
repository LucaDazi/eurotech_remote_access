import 'package:flutter/material.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/pages/devices_list.dart';
import 'package:remote_access/pages/rules_list.dart';

import 'package:remote_access/pages/settings.dart';
import 'package:remote_access/pages/users_list.dart';

class DashboardDestinations {
  const DashboardDestinations(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<DashboardDestinations> destinations = <DashboardDestinations>[
  DashboardDestinations(
    'Gateways',
    Icon(Icons.router_outlined),
    Icon(Icons.router),
  ),
  DashboardDestinations(
    'Users',
    Icon(Icons.people_outline),
    Icon(Icons.people),
  ),
  DashboardDestinations(
    'Rules',
    Icon(Icons.account_tree_outlined),
    Icon(Icons.account_tree),
  ),
  DashboardDestinations(
    'Settings',
    Icon(Icons.settings_outlined),
    Icon(Icons.settings),
  ),
];

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(child: _buildDestinationWidget(screenIndex)),
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
        return DevicesPage();
      case 1:
        return UsersPage();
      case 2:
        return RulesPage();
      case 3:
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
