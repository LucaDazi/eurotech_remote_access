import 'package:flutter/material.dart';
import 'package:remote_access/pages/admin_dashboard.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/user.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/pages/user_dashboard.dart';
import 'package:remote_access/pages/login.dart';

class InitialRouter extends StatelessWidget {
  const InitialRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: getIt<ApiService>().streamLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginForm();
        }
        if (snapshot.data!.isLoggedIn) {
          if (snapshot.data!.type == UserType.admin) {
            return AdminDashboard(currentUser: snapshot.data!);
          } else {
            return UserDashboard(currentUser: snapshot.data!);
          }
        } else {
          return const LoginForm();
        }
      },
    );
  }
}
