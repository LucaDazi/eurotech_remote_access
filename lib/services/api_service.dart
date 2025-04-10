import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_tree_view/listenable_node/listenable_node.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:remote_access/model/access_info.dart';
import 'package:remote_access/model/auth_info.dart';
import 'package:remote_access/model/auth_response.dart';
import 'package:remote_access/model/configuration/downstream_device.dart';
import 'package:remote_access/model/configuration/downstream_devices.dart';
import 'package:remote_access/model/configuration/partial_configurations.dart';
import 'package:remote_access/model/configuration/property.dart';
import 'package:remote_access/model/credentials.dart';
import 'package:remote_access/model/ec_account.dart';
import 'package:remote_access/model/ec_accounts_result.dart';
import 'package:remote_access/model/ec_create_credential.dart';
import 'package:remote_access/model/ec_credential_result.dart';
import 'package:remote_access/model/ec_credentials_result.dart';
import 'package:remote_access/model/ec_device.dart';
import 'package:remote_access/model/ec_devices_result.dart';
import 'package:remote_access/model/ec_roles_result.dart';
import 'package:remote_access/model/ec_user.dart';
import 'package:remote_access/model/ec_users_response.dart';
import 'package:remote_access/model/remote_access_device.dart';
import 'package:remote_access/model/rules/ec_tag.dart';
import 'package:remote_access/model/rules/ec_tags.dart';
import 'package:remote_access/model/rules/routing_rule.dart';
import 'package:remote_access/model/rules/routing_rules.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/model/user_profile.dart';
import 'package:remote_access/model/user_update.dart';
import 'package:remote_access/utilities/utilities.dart';

abstract class ApiService implements InterceptorContract {
  Client? _lazyClient;
  Client get client {
    _lazyClient ??= InterceptedClient.build(
      interceptors: [this],
      client: http.Client(),
    );
    return _lazyClient!;
  }

  String authToken = '';
  String cachedUser = '';
  String cachedPassword = '';
  String cachedApiKey = '';
  User? currentUser;
  TreeNode<dynamic>? currentDeviceTree;
  List<RemoteAccessDevice> currentDDList = [];
  List<EcUser> currentUsers = [];
  List<RoutingRule> routingRules = [];
  String remoteAccessTagId = '';

  bool loggedInByApiKey = false;

  String getCachedUser() {
    return cachedUser;
  }

  String getCachedPassword() {
    return cachedPassword;
  }

  String getCachedApiKey() {
    return cachedApiKey;
  }

  Future<User> getCurrentUser() {
    return Future.value(currentUser ?? User(loggedIn: false));
  }

  List<RemoteAccessDevice> getRemoteAccessDevices() => currentDDList;
  List<EcUser> getRemoteAccessUsers() => currentUsers;

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    final currentHeaders = request.headers;
    currentHeaders.addAll(_getAuthorizationHeaders());

    return request.copyWith(headers: currentHeaders);
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response.statusCode == 401) {
      debugPrint(
        'interceptResponse response.statusCode : ${response.statusCode}\ninterceptResponse response.request!.url.path : ${response.request!.url.path}\n',
      );
      /*
      if (response.request!.url.path != 'v1/authentication/user' &&
          response.request!.url.path != 'v1/authentication/apikey') {
        if (loggedInByApiKey) {
          loginWithApiKey(cachedApiKey);
        } else {
          login(cachedUser, cachedPassword);
        }
      }
      */
    }
    return response;
  }

  Map<String, String> _getAuthorizationHeaders() {
    return {HttpHeaders.authorizationHeader: 'Bearer $authToken'};
  }

  Uri _getUri(String path, [String? query]) {
    if (query != null) {
      return Uri(
        scheme: 'https',
        host: 'api-sbx.everyware.io',
        path: path,
        query: query,
      );
    } else {
      return Uri(scheme: 'https', host: 'api-sbx.everyware.io', path: path);
    }
  }

  Future<http.Response> doGet(String path, [String? query]) async {
    debugPrint('doGet : ${_getUri(path)}');
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (query != null) {
      return await client.get(_getUri(path, query), headers: headers);
    } else {
      return await client.get(_getUri(path), headers: headers);
    }
  }

  Future<http.Response> doPost({
    required String path,
    Object? body,
    String? contentType,
  }) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: contentType ?? 'application/json',
      HttpHeaders.contentEncodingHeader: contentType ?? 'application/json',
      HttpHeaders.acceptHeader: contentType ?? 'application/json',
    };

    debugPrint('doPost : $path');

    return await client.post(_getUri(path), headers: headers, body: body);
  }

  Future<http.Response> doPut(String path, Object body) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.contentEncodingHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    debugPrint('doPut : $path');

    return await client.put(_getUri(path), headers: headers, body: body);
  }

  Future<http.Response> doDelete(String path) async {
    Map<String, String> headers = {HttpHeaders.acceptHeader: '*/*'};

    debugPrint('doDelete : $path');

    return await client.delete(_getUri(path), headers: headers);
  }

  Future<int> login(String user, String password);
  Future<int> loginWithApiKey(String apiKey);
  Future<bool> logout();
  Stream<User> streamLoggedIn();
  Future<List<EcUser>> getUsers();
  Future<bool> updateUserData(EcUser user);
  Future<bool> createNewUser(EcUser user);
  Future<Credentials> generateApiKey(EcUser user);
  Future<bool> deleteUser(String userId);
  Future<List<EcAccount>> getChildAccounts(String? accountId);
  Future<List<EcDevice>> getDevicesForAccount(String? accountId);
  Future<TreeNode<dynamic>> getDeviceTree(bool forceRefresh);
  Future<List<RoutingRule>> getRoutingRules(bool forceRefresh);
  Future<List<RoutingRule>> getFilteredRoutingRules();
  Future<bool> putRoutingRules(List<RoutingRule> rules);
  Future<bool> tunVpnConnect(String accountId, String deviceId);
  Future<bool> tunVpnDisconnect(String accountId, String deviceId);
}

class ApiServiceImpl extends ApiService {
  ApiServiceImpl() {
    _loggedStatusSink.add(User(loggedIn: false));
  }

  final _loggedStatusStreamController = StreamController<User>.broadcast();
  StreamSink<User> get _loggedStatusSink => _loggedStatusStreamController.sink;
  Stream<User> get loggedStatus => _loggedStatusStreamController.stream;

  Future<bool> checkAuthToken() async {
    final response = await doGet('/v1/authentication/info');
    if (response.statusCode == 200) {
      AuthInfo userInfo = AuthInfo.fromJson(jsonDecode(response.body));
      if (userInfo.rolePermission.length == 1 &&
          userInfo.rolePermission[0].permission.action == null) {
        debugPrint("ADMIN");
      } else {
        debugPrint("REMOTE USER");
      }
      User profile = await getUserFromAuthInfo(userInfo);
      _loggedStatusSink.add(profile);
      return true;
    } else {
      _loggedStatusSink.add(User(loggedIn: false));
      return false;
    }
  }

  @override
  Stream<User> streamLoggedIn() => loggedStatus;

  @override
  Future<int> login(String user, String password) async {
    if (!await checkAuthToken()) {
      final response = await doPost(
        path: 'v1/authentication/user',
        body: '{"username":"$user","password":"$password"}',
      );
      if (cachedUser != user || cachedPassword != password) {
        cachedUser = user;
        cachedPassword = password;
      }
      if (response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(
          jsonDecode(response.body),
        );
        authToken = authResponse.tokenId;
        debugPrint('login authToken : $authToken');
        await checkAuthToken();
        loggedInByApiKey = false;
        return 0; // success
      } else if (response.statusCode == 401) {
        _loggedStatusSink.add(User(loggedIn: false));
        return 1; // invalid credentials
      } else {
        _loggedStatusSink.add(User(loggedIn: false));
        return 2; // other error
      }
    } else {
      _loggedStatusSink.add(User(loggedIn: false));
      return 0; // already logged in
    }
  }

  @override
  Future<int> loginWithApiKey(String apiKey) async {
    // TEST API KEY ieKbUmj+GINcIFKs8qn1FF1IHVUrHnk9wVhkB4bq
    if (!await checkAuthToken()) {
      final response = await doPost(
        path: '/v1/authentication/apikey',
        body: '{"apiKey":"$apiKey"}',
      );
      if (cachedApiKey != apiKey) {
        cachedApiKey = apiKey;
      }
      if (response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(
          jsonDecode(response.body),
        );
        authToken = authResponse.tokenId;
        debugPrint('loginWithApiKey authToken : $authToken');
        await checkAuthToken();
        loggedInByApiKey = true;
        return 0; // success
      } else if (response.statusCode == 401) {
        _loggedStatusSink.add(User(loggedIn: false));
        return 1; // invalid credentials
      } else {
        _loggedStatusSink.add(User(loggedIn: false));
        return 2; // other error
      }
    } else {
      _loggedStatusSink.add(User(loggedIn: false));
      return 0; // already logged in
    }
  }

  @override
  Future<bool> logout() async {
    final response = await doPost(path: '/v1/authentication/logout');
    if (response.statusCode == 204) {
      authToken = '';
      _loggedStatusSink.add(User(loggedIn: false));
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUserFromAuthInfo(AuthInfo info) async {
    final response = await doGet('v1/user/profile');
    late UserProfile profile;
    if (response.statusCode == 200) {
      profile = UserProfile.fromJson(jsonDecode(response.body));
    } else {
      profile = UserProfile(
        displayName: 'unknown',
        email: 'unknown',
        phoneNumber: 'unknown',
      );
    }

    // Sort the role permissions by domain and then by action
    info.rolePermission.sort((a, b) {
      int domainComparison = (a.permission.domain ?? '').compareTo(
        b.permission.domain ?? '',
      );
      if (domainComparison != 0) {
        return domainComparison;
      }
      return (a.permission.action ?? '').compareTo(b.permission.action ?? '');
    });

    int permIndex = 0;
    bool isRemoteUser =
        ((info.rolePermission.length == 4) &&
            (info.rolePermission[permIndex].permission.action == 'write' &&
                info.rolePermission[permIndex++].permission.domain ==
                    'device_management') &&
            (info.rolePermission[permIndex].permission.action == 'read' &&
                info.rolePermission[permIndex++].permission.domain == 'tag') &&
            (info.rolePermission[permIndex].permission.action == 'connect' &&
                info.rolePermission[permIndex++].permission.domain == 'vpn') &&
            (info.rolePermission[permIndex].permission.action == 'read' &&
                info.rolePermission[permIndex++].permission.domain == 'vpn'));
    bool isAdmin =
        (info.rolePermission.length == 1) &&
        (info.rolePermission[0].permission.action == null &&
            info.rolePermission[0].permission.domain == null);
    currentUser = User(
      loggedIn: true,
      name: profile.displayName ?? 'unknown',
      email: profile.email ?? 'unknown',
      type:
          !isAdmin && !isRemoteUser
              ? UserType.other
              : isAdmin
              ? UserType.admin
              : UserType.remoteUser,
      authInfo: info,
    );
    return Future.value(currentUser);
  }

  @override
  Future<List<EcUser>> getUsers() async {
    List<EcUser> allUsers = [];
    currentUsers.clear();
    int limit = 20;
    int offset = 0;
    bool shouldContinue = true;

    while (shouldContinue) {
      try {
        final response = await doGet(
          'v1/_/users',
          'matchTerm=RA_&limit=$limit&offset=$offset',
        );
        if (response.statusCode == 200) {
          EcUsersResponse res = EcUsersResponse.fromJson(
            jsonDecode(response.body),
          );
          allUsers.addAll(res.items);
          currentUsers.addAll(res.items);

          if (res.limitExceeded) {
            offset += limit;
          } else {
            shouldContinue = false;
          }
        } else {
          // Handle error (e.g., throw an exception, log the error)
          debugPrint('Failed to fetch data: ${response.statusCode}');
          shouldContinue = false; // Stop fetching on error.
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // Handle network or parsing errors
        debugPrint('An error occurred: $e');
        shouldContinue = false; // Stop fetching on error.
        throw Exception('Network or parsing error');
      }
    }

    return Future.value(allUsers);
  }

  @override
  Future<bool> updateUserData(EcUser user) async {
    UserUpdate userUpdate = UserUpdate(
      type: 'user',
      optlock: user.optlock ?? 0,
      name: user.name,
      displayName: user.displayName,
      email: user.email,
      phoneNumber: '',
      status: user.status,
      userType: user.userType,
    );

    final response = await doPut(
      'v1/_/users/${user.id}',
      jsonEncode(userUpdate.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> createNewUser(EcUser user) async {
    final response = await doPost(
      path: '/v1/_/users',
      body: '{"name":"${user.name}"}',
    );
    if (response.statusCode == 201) {
      EcUser newUser = EcUser.fromJson(jsonDecode(response.body));
      newUser.displayName = user.displayName;
      newUser.email = user.email;
      // User created. Update with details.
      bool updateResult = await updateUserData(newUser);
      if (updateResult) {
        // User updated. Now setting the Role...
        // First retrieve Role ID by Role Name
        final roleResponse = await doGet(
          '/v1/_/roles',
          'name=RemoteAccessUser',
        );
        if (roleResponse.statusCode == 200) {
          EcRolesResult rolesResult = EcRolesResult.fromJson(
            jsonDecode(roleResponse.body),
          );
          String roleId = rolesResult.items![0].id;
          // Now assign the Role to the User
          AccessInfo accessInfo = AccessInfo(
            userId: newUser.id,
            roleIds: [roleId],
          );
          final accessInfoResponse = await doPost(
            path: '/v1/_/accessinfos',
            body: jsonEncode(accessInfo.toJson()),
          );
          if (accessInfoResponse.statusCode == 200) {
            // Role assigned successfully
            return true;
          } else {
            // Failed to assign role
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<Credentials> generateApiKey(EcUser user) async {
    // First clear user credentials
    await clearUserCredentials(user);
    // Create a password credential (used for VPN connection)
    String pwdResult = await generatePasswordCredential(user);
    if (pwdResult.isEmpty) {
      return Future.value(Credentials(user: user, pwd: '', apiKey: ''));
    }
    // Now create a new API key
    EcCreateCredential credential = EcCreateCredential(
      userId: user.id,
      credentialStatus: 'ENABLED',
      credentialType: 'API_KEY',
      expirationDate: DateTime.now().add(const Duration(days: 7)),
    );
    final createResult = await doPost(
      path: '/v1/_/credentials',
      body: jsonEncode(credential.toJson()),
    );
    if (createResult.statusCode == 201) {
      EcCredentialResult credentialResult = EcCredentialResult.fromJson(
        jsonDecode(createResult.body),
      );
      return Future.value(
        Credentials(
          user: user,
          pwd: pwdResult,
          apiKey: credentialResult.credentialKey!,
        ),
      );
    } else {
      return Future.value(Credentials(user: user, pwd: '', apiKey: ''));
    }
  }

  Future<String> generatePasswordCredential(EcUser user) async {
    EcCreateCredential credential = EcCreateCredential(
      userId: user.id,
      credentialStatus: 'ENABLED',
      credentialType: 'PASSWORD',
      credentialKey: generatePassword(),
      expirationDate: DateTime.now().add(const Duration(days: 7)),
    );
    final credentialResponse = await doPost(
      path: '/v1/_/credentials',
      body: jsonEncode(credential.toJson()),
    );
    if (credentialResponse.statusCode == 201) {
      return Future.value(credential.credentialKey);
    } else {
      return Future.value('');
    }
  }

  Future<List<EcCredentialResult>> getUserCredentials(EcUser user) async {
    final response = await doGet('/v1/_/credentials', 'userId=${user.id}');
    if (response.statusCode == 200) {
      EcCredentialsResult res = EcCredentialsResult.fromJson(
        jsonDecode(response.body),
      );
      if (res.items != null) {
        return Future.value(res.items!);
      } else {
        return Future.value([]);
      }
    } else {
      return Future.value([]);
    }
  }

  Future<bool> deleteUserCredential(String credentialId) async {
    final response = await doDelete('/v1/_/credentials/$credentialId');
    if (response.statusCode == 204) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> clearUserCredentials(EcUser user) async {
    List<EcCredentialResult> credentials = await getUserCredentials(user);
    for (EcCredentialResult credential in credentials) {
      await deleteUserCredential(credential.id);
    }
    return Future.value(true);
  }

  @override
  Future<bool> deleteUser(String userId) async {
    final response = await doDelete('/v1/_/users/$userId');
    if (response.statusCode == 204) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<List<EcAccount>> getChildAccounts(String? accountId) async {
    List<EcAccount> allAccounts = [];
    int limit = 20;
    int offset = 0;
    bool shouldContinue = true;

    while (shouldContinue) {
      try {
        final accountString = accountId ?? '_';
        final response = await doGet(
          'v1/$accountString/accounts',
          'limit=$limit&offset=$offset',
        );
        if (response.statusCode == 200) {
          EcAccountsResult res = EcAccountsResult.fromJson(
            jsonDecode(response.body),
          );
          allAccounts.addAll(res.items);
          if (res.limitExceeded) {
            offset += limit;
          } else {
            shouldContinue = false;
          }
        } else {
          // Handle error (e.g., throw an exception, log the error)
          debugPrint('Failed to fetch data: ${response.statusCode}');
          shouldContinue = false; // Stop fetching on error.
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // Handle network or parsing errors
        debugPrint('An error occurred: $e');
        shouldContinue = false; // Stop fetching on error.
        throw Exception('Network or parsing error');
      }
    }

    return Future.value(allAccounts);
  }

  Future<List<DownstreamDevice>> getDownstreamDevicesForDevice(
    EcAccount account,
    EcDevice device,
  ) async {
    final List<DownstreamDevice> result = [];
    final response = await doGet(
      'v1/${account.id}/devices/${device.id}/configurations/com.eurotech.framework.openvpn.bridged.OpenVpnBridge',
    );
    if (response.statusCode == 200) {
      EcConfigurations res = EcConfigurations.fromJson(
        jsonDecode(response.body),
      );
      for (Property p in res.configuration[0].properties.property) {
        if (p.name == 'downstream.devices') {
          DownstreamDevices dds = DownstreamDevices.fromJson(
            jsonDecode(p.value[0]),
          );
          for (DownstreamDevice dd in dds.devices) {
            result.add(dd);
            currentDDList.add(
              RemoteAccessDevice(
                downstreamDevice: dd,
                device: device,
                account: account,
              ),
            );
          }
          break;
        }
      }
    } else {
      // Handle error (e.g., throw an exception, log the error)
      debugPrint('Failed to fetch data: ${response.statusCode}');
      //throw Exception('Failed to load data');
    }
    return result;
  }

  @override
  Future<List<EcDevice>> getDevicesForAccount(String? accountId) async {
    List<EcDevice> allDevices = [];
    int limit = 20;
    int offset = 0;
    bool shouldContinue = true;

    if (remoteAccessTagId.isEmpty) {
      remoteAccessTagId = await getRemoteAccessTagId();
    }

    while (shouldContinue) {
      try {
        final accountString = accountId ?? '_';
        final response = await doGet(
          'v1/$accountString/devices',
          'tagId=$remoteAccessTagId&limit=$limit&offset=$offset',
        );
        if (response.statusCode == 200) {
          EcDevicesResult res = EcDevicesResult.fromJson(
            jsonDecode(response.body),
          );
          for (EcDevice d in res.items) {
            if (d.applicationIdentifiers != null &&
                d.applicationIdentifiers!.contains('TAP-V1')) {
              allDevices.add(d);
            }
          }
          if (res.limitExceeded) {
            offset += limit;
          } else {
            shouldContinue = false;
          }
        } else {
          // Handle error (e.g., throw an exception, log the error)
          debugPrint('Failed to fetch data: ${response.statusCode}');
          shouldContinue = false; // Stop fetching on error.
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // Handle network or parsing errors
        debugPrint('An error occurred: $e');
        shouldContinue = false; // Stop fetching on error.
        throw Exception('Network or parsing error');
      }
    }

    return Future.value(allDevices);
  }

  Future<EcAccount> getMainAccount() async {
    final response = await doGet('v1/account');
    if (response.statusCode == 200) {
      EcAccount result = EcAccount.fromJson(jsonDecode(response.body));
      return result;
    } else {
      // Handle error (e.g., throw an exception, log the error)
      debugPrint('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<TreeNode<dynamic>> getDeviceTree(bool forceRefresh) async {
    if (forceRefresh) {
      currentDeviceTree = null;
      currentDDList.clear();
    }
    if (currentDeviceTree != null) {
      return Future.value(currentDeviceTree);
    }
    List<EcAccount> accounts = await getChildAccounts('_');
    EcAccount mainAccount = await getMainAccount();
    mainAccount.visibleInUi = true;

    Iterable<TreeNode> mapAccountsToTreeNodes(List<EcAccount> accounts) sync* {
      for (final account in accounts) {
        yield TreeNode(key: account.id, data: account);
      }
    }

    Iterable<TreeNode> mapDevicesToTreeNodes(List<EcDevice> devices) sync* {
      for (final device in devices) {
        yield TreeNode(key: device.id, data: device);
      }
    }

    final TreeNode<dynamic> resultTree =
        TreeNode.root()..addAll(mapAccountsToTreeNodes(accounts));
    resultTree.data = mainAccount;

    List<EcDevice> rootDevices = await getDevicesForAccount('_');
    resultTree.root.addAll(mapDevicesToTreeNodes(rootDevices));
    for (EcDevice device in rootDevices) {
      List<DownstreamDevice> dds = await getDownstreamDevicesForDevice(
        mainAccount,
        device,
      );
      _addDownstreamDevicesToDeviceTree(device.id, dds, resultTree);
    }

    for (EcAccount account in accounts) {
      List<EcDevice> devices = await getDevicesForAccount(account.id);

      //Add all devices to the relevant account
      resultTree.childrenAsList
          .firstWhere((element) => element.key == account.id)
          .addAll(mapDevicesToTreeNodes(devices));

      for (EcDevice device in devices) {
        List<DownstreamDevice> dds = await getDownstreamDevicesForDevice(
          account,
          device,
        );
        _addDownstreamDevicesToDeviceTree(device.id, dds, resultTree);
      }
    }

    currentDeviceTree = resultTree;
    return Future.value(resultTree);
  }

  void _addDownstreamDevicesToDeviceTree(
    String deviceId,
    List<DownstreamDevice> dds,
    TreeNode<dynamic> tree,
  ) {
    Iterable<TreeNode> mapDownstreamDevicesToTreeNodes(
      List<DownstreamDevice> downstreamDevices,
    ) sync* {
      for (final dd in downstreamDevices) {
        yield TreeNode(key: dd.name, data: dd);
      }
    }

    ListenableNode? deviceNode = findDeviceById(tree, deviceId);

    if (deviceNode != null) {
      deviceNode.addAll(mapDownstreamDevicesToTreeNodes(dds));
    }
  }

  ListenableNode? findDeviceById(dynamic root, String deviceId) {
    if (root is TreeNode) {
      if (root.data is EcDevice) {
        if ((root.data as EcDevice).id == deviceId) {
          return root;
        }
      }
      if (root.data is EcAccount) {
        for (final child in root.children.entries) {
          final foundItem = findDeviceById(child.value, deviceId);
          if (foundItem != null) {
            return foundItem;
          }
        }
      }
      if (root.data == null) {
        // Root node?
        for (final child in root.children.entries) {
          final foundItem = findDeviceById(child.value, deviceId);
          if (foundItem != null) {
            return foundItem;
          }
        }
      }
    }
    return null;
  }

  Future<String> getRemoteAccessTagId() async {
    final response = await doGet('v1/_/tags', 'name=RemoteAccess');
    if (response.statusCode == 200) {
      EcTags result = EcTags.fromJson(jsonDecode(response.body));
      if (result.items.isNotEmpty) {
        return result.items[0].id;
      }
    }
    return '';
  }

  @override
  Future<List<RoutingRule>> getFilteredRoutingRules() async {
    List<RoutingRule> result = await getRoutingRules(false);
    result.removeWhere(
      (element) => element.userId != currentUser!.authInfo!.accessToken.userId,
    );
    return result;
  }

  @override
  Future<List<RoutingRule>> getRoutingRules(bool forceRefresh) async {
    if (forceRefresh) {
      routingRules = [];
    }
    if (routingRules.isNotEmpty) {
      return Future.value(routingRules);
    }
    final response = await doGet('v1/_/tags', 'name=RoutingRules');
    if (response.statusCode == 200) {
      EcTags result = EcTags.fromJson(jsonDecode(response.body));
      if (result.items.isEmpty) {
        //No Rule found, creating an empty one.
        routingRules = [];
        await putRoutingRules(routingRules);
        return Future.value(routingRules);
      }
      final escaped = result.items[0].description;
      final decoded = jsonDecode(escaped);
      RoutingRules rules = RoutingRules.fromJson(jsonDecode(decoded));
      debugPrint('NUMBER OF RULES IN JSON 1: ${rules.rules.length}');
      for (RoutingRule rr in rules.rules) {
        for (RemoteAccessDevice rad in currentDDList) {
          if (rr.accountId == rad.account.id && rr.deviceId == rad.device.id) {
            rr.account = rad.account;
            rr.device = rad.device;
            break;
          }
        }
        for (EcUser user in currentUsers) {
          if (rr.userId == user.id) {
            rr.user = user;
            break;
          }
        }
      }
      routingRules = [];
      routingRules.addAll(rules.rules);
      debugPrint('NUMBER OF RULES IN JSON 2: ${rules.rules.length}');
      return Future.value(routingRules);
    } else {
      debugPrint('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<bool> putRoutingRules(List<RoutingRule> rules) async {
    final EcTag target;
    final response = await doGet('v1/_/tags', 'name=RoutingRules');
    if (response.statusCode == 200) {
      EcTags result = EcTags.fromJson(jsonDecode(response.body));
      if (result.items.isNotEmpty) {
        // Store tag for later update
        target = result.items[0];
      } else {
        final createResponse = await doPost(
          path: 'v1/_/tags',
          body: jsonEncode(<String, dynamic>{
            'name': 'RoutingRules',
            'description': '',
          }),
        );
        if (createResponse.statusCode == 201) {
          target = EcTag.fromJson(jsonDecode(createResponse.body));
        } else {
          debugPrint('Failed to post data: ${response.statusCode}');
          throw Exception('Failed to post data');
        }
      }
    } else {
      debugPrint('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
    routingRules = rules;
    RoutingRules rr = RoutingRules(rules: routingRules);
    final payload = jsonEncode(jsonEncode(rr));
    target.description = payload;

    final putResponse = await doPut(
      '/v1/_/tags/${target.id}',
      jsonEncode(target.toJson()),
    );
    if (putResponse.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> tunVpnConnect(String accountId, String deviceId) async {
    final response = await doPost(
      path: '/v1/$accountId/devices/$deviceId/vpn/_connect',
    );
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> tunVpnDisconnect(String accountId, String deviceId) async {
    final response = await doPost(
      path: '/v1/$accountId/devices/$deviceId/vpn/_disconnect',
    );
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
