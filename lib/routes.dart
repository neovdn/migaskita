import 'package:flutter/material.dart';
import 'package:flutter_migaskita/presentation/pages/auth/login_page.dart';
import 'package:flutter_migaskita/presentation/pages/auth/sign_up_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/home_page.dart';

class Routes {
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case home:
        return MaterialPageRoute(
          builder: (_) => EmployeeHomePage(),
        ); // Sesuaikan dengan role
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }

  static EmployeeHomePage() {}
}
