import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/widgets/routing_rule_card.dart';

class RemoteDevicesPage extends StatefulWidget {
  const RemoteDevicesPage({super.key});

  @override
  State<RemoteDevicesPage> createState() => _RemoteDevicesPageState();
}

class _RemoteDevicesPageState extends State<RemoteDevicesPage> {
  @override
  void initState() {
    super.initState();
  }

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
                      title: Text(
                        'Logged in as ${getIt<ApiService>().currentUser!.name}',
                      ),
                      subtitle: Text(
                        '${getIt<ApiService>().currentUser!.email}',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FutureBuilder<List<RoutingRule>>(
                        future: getIt<ApiService>().getFilteredRoutingRules(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return RoutingRuleCard(
                                routingRule: snapshot.data![index],
                              );
                            },
                          );
                        },
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
