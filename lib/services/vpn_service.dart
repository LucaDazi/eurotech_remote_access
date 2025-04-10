import 'dart:io';

import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

abstract class VpnService {
  int? openVpnPid;
  Future<void> testConnection(String openVpnConfigPath, String openVpnCredPath);
  Future<bool> terminateVpnConnection();
}

class VpnServiceImpl implements VpnService {
  @override
  Future<void> testConnection(
    String openVpnConfigPath,
    String openVpnCredPath,
  ) async {
    final String openVpnPath = 'C:\\Program Files\\OpenVPN\\bin\\openvpn.exe';
    try {
      final process = await Process.start(openVpnPath, [
        '--config',
        openVpnConfigPath,
        '--auth-user-pass',
        openVpnCredPath,
      ]);
      openVpnPid = process.pid;
      debugPrint('OpenVPN Process started with PID: ${process.pid}');

      // Optionally, listen for output and errors
      process.stdout.listen((List<int> data) {
        debugPrint('OpenVPN Output: ${String.fromCharCodes(data)}');
      });
      process.stderr.listen((List<int> data) {
        debugPrint('OpenVPN Error: ${String.fromCharCodes(data)}');
      });

      // You might want to track the process to know when it exits
      final exitCode = await process.exitCode;

      debugPrint('OpenVPN process exited with code: $exitCode');
    } catch (e) {
      debugPrint('Error starting OpenVPN: $e');
    }
    return Future.value();
  }

  @override
  int? openVpnPid;

  @override
  Future<bool> terminateVpnConnection() async {
    if (openVpnPid == null) {
      return Future.value(false);
    }
    const int processTerminate = 0x0001;
    final processHandle = OpenProcess(processTerminate, 0, openVpnPid!);

    if (processHandle == 0xff) {
      debugPrint(
        'Error: Could not open process with PID $openVpnPid. Error code: ${GetLastError()}',
      );
      return Future.value(false);
    }

    final terminateResult = TerminateProcess(processHandle, 0);
    CloseHandle(processHandle);

    if (terminateResult == 0) {
      debugPrint(
        'Error: Failed to terminate process with PID $openVpnPid. Error code: ${GetLastError()}',
      );
      return Future.value(false);
    }

    debugPrint('Process with PID $openVpnPid terminated successfully.');
    openVpnPid = null;

    return Future.value(true);
  }
}
