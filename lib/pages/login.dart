import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/services/api_service.dart';

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
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Column(
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
                                children: [
                                  Expanded(child: Container()),
                                  TextFormField(
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                  ),
                                  FilledButton(
                                    onPressed:
                                        _loggingIn
                                            ? null
                                            : () async {
                                              if (_userAndPwdFormKey
                                                  .currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _loggingIn = true;
                                                });
                                                // Perform login action
                                                int loginResult = await getIt<
                                                      ApiService
                                                    >()
                                                    .login(
                                                      _usernameController.text,
                                                      _passwordController.text,
                                                    );
                                                if (loginResult != 0) {
                                                  const snackBar = SnackBar(
                                                    content: Text(
                                                      'Unauthorized!',
                                                    ),
                                                  );
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(snackBar);
                                                  }
                                                }
                                                setState(() {
                                                  _loggingIn = false;
                                                });
                                              }
                                            },
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
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your API key';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                  ),
                                  FilledButton(
                                    onPressed:
                                        _loggingIn
                                            ? null
                                            : () async {
                                              if (_apiKeyFormKey.currentState!
                                                  .validate()) {
                                                // Perform login action
                                                setState(() {
                                                  _loggingIn = true;
                                                });
                                                int loginResult =
                                                    await getIt<ApiService>()
                                                        .loginWithApiKey(
                                                          _apiKeyController
                                                              .text,
                                                        );
                                                if (loginResult != 0) {
                                                  const snackBar = SnackBar(
                                                    content: Text(
                                                      'Unauthorized!',
                                                    ),
                                                  );
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(snackBar);
                                                  }
                                                }
                                                setState(() {
                                                  _loggingIn = false;
                                                });
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
