import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/ec_vpn_config.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulid/ulid.dart';
import 'package:win32/win32.dart';

abstract class VpnService {
  int? _openVpnTunPid;

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  StreamController<String> _openVpnStdoutController =
      StreamController<String>();

  Stream<String> get openVpnStdout => _openVpnStdoutController.stream;

  Future<void> _storeTunPid(int pid) async {
    await _preferences.setInt(ApplicationPreferences.openVpnTunPid, pid);
    _openVpnTunPid = pid;
  }

  Future<void> _removeTunPid() async {
    await _preferences.remove(ApplicationPreferences.openVpnTunPid);
    _openVpnTunPid = null;
  }

  bool get isTunVpnActive => _openVpnTunPid != null;

  Future<void> testConnection(String openVpnConfigPath, String openVpnCredPath);
  Future<void> initiateVpnConnection(RoutingRule rule, String user, String pwd);
  Future<bool> terminateVpnConnection();
}

class VpnServiceImpl extends VpnService {
  @override
  Future<void> testConnection(
    String openVpnConfigPath,
    String openVpnCredPath,
  ) async {
    String? binFolder =
        await _preferences.getString(ApplicationPreferences.openVpnBinFolder) ??
        'C:\\Program Files\\OpenVPN\\bin';

    final String openVpnPath = '$binFolder\\openvpn.exe';
    try {
      final process = await Process.start(openVpnPath, [
        '--config',
        openVpnConfigPath,
        '--auth-user-pass',
        openVpnCredPath,
      ]);
      await _storeTunPid(process.pid);
      debugPrint('OpenVPN Process started with PID: ${process.pid}');

      _openVpnStdoutController = StreamController<String>();

      process.stdout.listen((List<int> data) {
        final output = String.fromCharCodes(data);
        _openVpnStdoutController.add(output);
      });
      process.stderr.listen((List<int> data) {
        final output = String.fromCharCodes(data);
        _openVpnStdoutController.addError(output);
      });
    } catch (e) {
      debugPrint('Error starting OpenVPN: $e');
    }
    return Future.value();
  }

  @override
  Future<void> initiateVpnConnection(
    RoutingRule rule,
    String user,
    String pwd,
  ) async {
    final tmpPath = await getTemporaryDirectory();
    String credUlid = Ulid().toUuid();
    final File tmpCreds = File('${tmpPath.path}\\$credUlid');
    await tmpCreds.writeAsString('$user\n$pwd');
    EcVpnConfig vpnConfig = await getIt<ApiService>().getVpnConfig(
      rule.accountId,
    );
    String confUlid = Ulid().toUuid();
    final File tmpConfig = File('${tmpPath.path}\\$confUlid');
    await tmpConfig.writeAsString(vpnConfig.configurationFile);

    await testConnection(tmpConfig.path, tmpCreds.path);

    Future.delayed(Duration(seconds: 60)).then((value) {
      tmpCreds.delete();
      tmpConfig.delete();
    });
  }

  @override
  Future<bool> terminateVpnConnection() async {
    if (_openVpnTunPid == null) {
      return Future.value(false);
    }
    const int processTerminate = 0x0001;
    final processHandle = OpenProcess(processTerminate, 0, _openVpnTunPid!);

    if (processHandle == 0xff) {
      debugPrint(
        'Error: Could not open process with PID $_openVpnTunPid. Error code: ${GetLastError()}',
      );
      return Future.value(false);
    }

    final terminateResult = TerminateProcess(processHandle, 0);
    CloseHandle(processHandle);

    if (terminateResult == 0) {
      debugPrint(
        'Error: Failed to terminate process with PID $_openVpnTunPid. Error code: ${GetLastError()}',
      );
      return Future.value(false);
    }

    debugPrint('Process with PID $_openVpnTunPid terminated successfully.');
    _removeTunPid();

    _openVpnStdoutController.close();
    return Future.value(true);
  }
}
