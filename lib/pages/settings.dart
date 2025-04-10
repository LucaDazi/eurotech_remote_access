import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/services/api_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<User>(
          future: getIt<ApiService>().getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                margin: EdgeInsets.all(16.0),
                child: DefaultTextStyle(
                  style: DefaultTextStyle.of(
                    context,
                  ).style.copyWith(fontSize: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.getType(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Name: ${snapshot.data!.name!}'),
                        Text('Email: ${snapshot.data!.email!}'),
                        Text(
                          'Token expires on: ${snapshot.data!.authInfo!.accessToken.expiresOn}',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Tooltip(
                              waitDuration: Duration(seconds: 1),
                              message: 'Logout',
                              child: FilledButton(
                                onPressed: () async {
                                  getIt<ApiService>().logout();
                                },
                                child: Icon(Icons.logout),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
