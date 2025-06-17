import 'package:flutter/material.dart';
import 'package:flutter_migaskita/presentation/pages/auth/login_page.dart';
import 'package:flutter_migaskita/presentation/pages/auth/sign_up_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/home_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/calendar_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/activity_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/profile_page.dart';

class Routes {
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String employeeHome = '/employee-home';
  static const String employeeCalendar = '/employee-calendar';
  static const String employeeActivity = '/employee-activity';
  static const String employeeProfile = '/employee-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case employeeHome:
        return MaterialPageRoute(builder: (_) => EmployeeHomePage());
      case employeeCalendar:
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case employeeActivity:
        return MaterialPageRoute(builder: (_) => EmployeeActivityPage());
      case employeeProfile:
        return MaterialPageRoute(builder: (_) => EmployeeProfilePage());
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
}
