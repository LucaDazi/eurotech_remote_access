import 'package:remote_access/model/auth_info.dart';

enum UserType { admin, remoteUser, other }

class User {
  User({
    required this.loggedIn,
    this.name,
    this.email,
    this.type,
    this.authInfo,
  });

  final String? name;
  final String? email;
  final UserType? type;
  final bool loggedIn;
  final AuthInfo? authInfo;

  bool get isLoggedIn => loggedIn;

  String getType() {
    switch (type) {
      case UserType.admin:
        return 'System Administrator';
      case UserType.remoteUser:
        return 'Remote Access User';
      default:
        return 'Other User';
    }
  }
}
