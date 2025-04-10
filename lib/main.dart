import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remote_access/router.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/services/vpn_service.dart';
import 'package:remote_access/utilities/palette.dart';

GetIt getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<ApiService>(ApiServiceImpl());
  getIt.registerSingleton<VpnService>(VpnServiceImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eurotech Remote Access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.kEurotech),
      ),
      home: const InitialRouter(),
    );
  }
}
