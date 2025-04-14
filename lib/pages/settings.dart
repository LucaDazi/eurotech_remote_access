import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/preferences/admin_preferences.dart';
import 'package:remote_access/model/preferences/user_preferences.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/utilities/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _working = false;
  late AdminPreferences _adminPreferences;
  late UserPreferences _userPreferences;
  TextEditingController _folderPathController = TextEditingController();

  @override
  void dispose() {
    _folderPathController.dispose();
    super.dispose();
  }

  Future<void> _selectFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
      initialDirectory: _folderPathController.text,
    );

    if (selectedDirectory != null) {
      setState(() {
        _folderPathController.text = selectedDirectory;
      });
      await getIt<ApiService>().getSharedPreferences.setString(
        ApplicationPreferences.openVpnBinFolder,
        selectedDirectory,
      );
    }
  }

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
              UserType userType = snapshot.data!.type!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
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
                  ),
                  if (userType == UserType.admin)
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DefaultTextStyle(
                          style: DefaultTextStyle.of(
                            context,
                          ).style.copyWith(fontSize: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Everyware Cloud Account',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: double.infinity),
                              FutureBuilder<AdminPreferences>(
                                future:
                                    getIt<ApiService>().getAdminPreferences(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          Text('Loading Preferences...'),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  }
                                  _adminPreferences = snapshot.data!;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value:
                                                _adminPreferences
                                                    .allowDevelopmentServers,
                                            onChanged:
                                                _working
                                                    ? null
                                                    : (value) async {
                                                      await switchDevCheck(
                                                        value!,
                                                      );
                                                    },
                                          ),
                                          Text('Allow Development servers'),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (userType == UserType.remoteUser)
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DefaultTextStyle(
                          style: DefaultTextStyle.of(
                            context,
                          ).style.copyWith(fontSize: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OpenVPN Client',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: double.infinity),
                              FutureBuilder<UserPreferences>(
                                future:
                                    getIt<ApiService>().getUserPreferences(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          Text('Loading Preferences...'),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  }
                                  _userPreferences = snapshot.data!;
                                  _folderPathController.text =
                                      _userPreferences.openVpnBinFolder;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 8),
                                          TextFormField(
                                            controller: _folderPathController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter Folder Path',
                                              border: OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                onPressed: _selectFolder,
                                                icon: Icon(Icons.folder_open),
                                              ),
                                              helperText:
                                                  'OpenVPN bin folder. This folder container the executables used to start the OpenVPN connections.',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Future<void> switchDevCheck(bool value) async {
    setState(() {
      _working = true;
    });
    await getIt<ApiService>().getSharedPreferences.setBool(
      ApplicationPreferences.allowDevelopmentServers,
      value,
    );
    _adminPreferences = await getIt<ApiService>().getAdminPreferences();
    setState(() {
      _working = false;
    });
  }
}
