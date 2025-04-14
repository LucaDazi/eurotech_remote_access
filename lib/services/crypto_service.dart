import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:ulid/ulid.dart';

abstract class CryptoService {
  Future<String> generateActivationToken(
    String apiKey,
    String user,
    String pwd,
  );

  Future<JWT?> decodeActivationToken(String token);
}

class CryptoServiceImpl extends CryptoService {
  CryptoServiceImpl();

  @override
  Future<String> generateActivationToken(
    String apiKey,
    String user,
    String pwd,
  ) {
    final jwt = JWT(
      {
        'id': Ulid().toUuid(),
        'apiKey': apiKey,
        'credentials': {'user': user, 'password': pwd},
      },
      issuer: 'com.eurotech.remote.access',
      subject: 'Remote Access Token',
    );

    final pem = File('./certs/private.pem').readAsStringSync();
    final key = ECPrivateKey(pem);

    final token = jwt.sign(key, algorithm: JWTAlgorithm.ES256);
    return Future.value(token);
  }

  @override
  Future<JWT?> decodeActivationToken(String token) {
    try {
      final pem = File('./certs/public.pem').readAsStringSync();
      final key = ECPublicKey(pem);

      final jwt = JWT.verify(token, key);
      return Future.value(jwt);
    } on JWTExpiredException {
      debugPrint('JWT Expired!');
      return Future.value(null);
    } on JWTException catch (e) {
      debugPrint('JWT Exception: $e');
      return Future.value(null);
    }
  }
}
