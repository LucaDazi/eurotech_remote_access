import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/ec_instance.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _userAndPwdFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _apiKeyFormKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();

  EcInstance? _selectedEcInstance;
  late List<EcInstance> _ecInstances;
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  bool _loggingIn = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text = getIt<ApiService>().getCachedUser();
    _passwordController.text = getIt<ApiService>().getCachedPassword();
    _apiKeyController.text = getIt<ApiService>().getCachedApiKey();
  }

  @override
  void dispose() {
    // Dispose of any controllers or resources here
    _usernameController.dispose();
    _passwordController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eurotech Remote Access'), centerTitle: true),
      body: FutureBuilder<EcInstance>(
        future: getIt<ApiService>().loadEcInstancesAndReturnCurrent(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          _ecInstances = getIt<ApiService>().getEcInstances;
          _selectedEcInstance = snapshot.data!;
          final autoLogin = getIt<ApiService>().automaticLogin;
          return autoLogin
              ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Text('Long text to be displayed as a user banner'),
                    SizedBox(height: 16.0),
                    FilledButton(
                      onPressed:
                          _loggingIn
                              ? null
                              : () {
                                onApiKeyPressed(
                                  context,
                                  getIt<ApiService>().cachedApiKey,
                                  _selectedEcInstance!,
                                );
                              },
                      child:
                          _loggingIn
                              ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Logging in...'),
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                ],
                              )
                              : Text('Start'),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                    width: 600,
                    height: 400,
                    child: DefaultTabController(
                      length: 2,
                      child: Card(
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(text: 'Username/Password'),
                                Tab(text: 'API Key'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  // Login Form
                                  Form(
                                    key: _userAndPwdFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 64.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(child: Container()),
                                          TextFormField(
                                            controller: _usernameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Username',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your username';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: _passwordController,
                                            decoration: const InputDecoration(
                                              labelText: 'Password',
                                            ),
                                            obscureText: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          _getEcDropdown(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed:
                                                _loggingIn
                                                    ? null
                                                    : onUserAndPwdPressed,
                                            child: const Text('Login'),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // API Key Form
                                  Form(
                                    key: _apiKeyFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 64.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(child: Container()),
                                          TextFormField(
                                            controller: _apiKeyController,
                                            decoration: const InputDecoration(
                                              labelText: 'API Key',
                                            ),
                                            obscureText: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your API key';
                                              }
                                              return null;
                                            },
                                          ),
                                          _getEcDropdown(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                          ),
                                          FilledButton(
                                            onPressed:
                                                _loggingIn
                                                    ? null
                                                    : () {
                                                      if (_apiKeyFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        onApiKeyPressed(
                                                          context,
                                                          _apiKeyController
                                                              .text,
                                                          _selectedEcInstance!,
                                                        );
                                                      }
                                                    },
                                            child: const Text('Login'),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_loggingIn)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              );
        },
      ),
    );
  }

  void onApiKeyPressed(
    BuildContext context,
    String apiKey,
    EcInstance instance,
  ) async {
    // Perform login action
    setState(() {
      _loggingIn = true;
    });
    int loginResult = await getIt<ApiService>().loginWithApiKey(
      apiKey,
      instance,
    );
    if (loginResult != 0) {
      const snackBar = SnackBar(content: Text('Unauthorized!'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    setState(() {
      _loggingIn = false;
    });
  }

  void onUserAndPwdPressed() async {
    if (_userAndPwdFormKey.currentState!.validate()) {
      setState(() {
        _loggingIn = true;
      });
      // Perform login action
      int loginResult = await getIt<ApiService>().login(
        _usernameController.text,
        _passwordController.text,
        _selectedEcInstance!,
      );
      if (loginResult != 0) {
        const snackBar = SnackBar(content: Text('Unauthorized!'));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      await prefs.setString(
        ApplicationPreferences.ecAccount,
        jsonEncode(_selectedEcInstance),
      );
      setState(() {
        _loggingIn = false;
      });
    }
  }

  DropdownButtonFormField<EcInstance> _getEcDropdown() {
    return DropdownButtonFormField<EcInstance>(
      decoration: const InputDecoration(labelText: 'Everyware Cloud instance'),
      items:
          _ecInstances.map<DropdownMenuItem<EcInstance>>((e) {
            return DropdownMenuItem<EcInstance>(
              value: e,
              child: Text('${e.friendlyName} (${e.region}-${e.subRegion})'),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedEcInstance = value!;
        });
        prefs.setString(
          ApplicationPreferences.ecAccount,
          jsonEncode(_selectedEcInstance!.toJson()),
        );
      },
      value: _selectedEcInstance,
    );
  }
}
