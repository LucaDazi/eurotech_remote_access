import 'package:flutter/material.dart';
import 'package:remote_access/pages/login.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                child: Form(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 64.0,
                              ),
                              child: Column(
                                children: [
                                  Expanded(child: Container()),
                                  TextFormField(
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
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Perform login action
                                      }
                                    },
                                    child: const Text('Login'),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                            // API Key Form
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 64.0,
                              ),
                              child: Column(
                                children: [
                                  Expanded(child: Container()),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'API Key',
                                    ),
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
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Perform login action
                                      }
                                    },
                                    child: const Text('Login'),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
