import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remote_access/router.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/services/crypto_service.dart';
import 'package:remote_access/services/vpn_service.dart';
import 'package:remote_access/utilities/palette.dart';

GetIt getIt = GetIt.instance;
void main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<ApiService>(ApiServiceImpl());
  getIt.registerSingleton<VpnService>(VpnServiceImpl());
  getIt.registerSingleton<CryptoService>(CryptoServiceImpl());

  //List<String> arguments = [
  //  'eth-ra://open?token=eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxOTYzNDMyLTg5MzctMjAzMi1jNWYwLTllZTQ2NDkwZWUwMiIsImFwaUtleSI6InVpaU1TRlVKci9TcGVjNHpDVld2dDU5TVpucmlJWCtsWUh4SThyYkQiLCJjcmVkZW50aWFscyI6eyJ1c2VyIjoiUkFfcmVtb3RlX2FjY2Vzc18xIiwicGFzc3dvcmQiOiJqS3slNS5wY2Y2RjAwKSFoIn0sImlhdCI6MTc0NDYzMjQ0OSwic3ViIjoiUmVtb3RlIEFjY2VzcyBUb2tlbiIsImlzcyI6ImNvbS5ldXJvdGVjaC5yZW1vdGUuYWNjZXNzIn0.88E6rjuotSPjAPOEsURBb_N8gi8-AfXOzSUZTqKPgD2Yow329-A7QV2CMDjXgQYFxtEQL-Iqp4srs_kDE2zvcw',
  //];

  if (arguments.isNotEmpty) {
    String receivedUrl = arguments.first;
    debugPrint('Application launched with URL: $receivedUrl');

    try {
      Uri uri = Uri.parse(receivedUrl);
      debugPrint('Scheme: ${uri.scheme}');
      debugPrint('Host: ${uri.host}');
      debugPrint('Path: ${uri.path}');
      debugPrint('Query Parameters: ${uri.queryParameters}');

      final receivedToken = uri.queryParameters['token'];
      final JWT? receivedJwt = await getIt<CryptoService>()
          .decodeActivationToken(receivedToken!);
      if (receivedJwt != null) {
        String receivedApiKey = receivedJwt.payload['apiKey'];
        String receivedUser = receivedJwt.payload['credentials']['user'];
        String receivedPassword =
            receivedJwt.payload['credentials']['password'];

        debugPrint('A:$receivedApiKey,U:$receivedUser,P:$receivedPassword');
        getIt<ApiService>().setAutomaticLogin(
          receivedApiKey,
          receivedUser,
          receivedPassword,
        );
      }
    } catch (e) {
      debugPrint('Tried to start app with invalid argument: $receivedUrl');
    }
  }

  runApp(MyApp());
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
