import 'package:remote_access/model/ec_user.dart';

class Credentials {
  Credentials({required this.user, required this.pwd, required this.apiKey});

  EcUser user;
  String pwd;
  String apiKey;
}
