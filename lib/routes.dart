import 'package:flutter/material.dart';
import 'package:flutter_migaskita/presentation/pages/auth/login_page.dart';
import 'package:flutter_migaskita/presentation/pages/auth/sign_up_page.dart';

// Employee Pages
import 'package:flutter_migaskita/presentation/pages/employee/home_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/calendar_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/activity_page.dart';
import 'package:flutter_migaskita/presentation/pages/employee/profile_page.dart';

// Admin Pages
import 'package:flutter_migaskita/presentation/pages/admin/home_page.dart';
import 'package:flutter_migaskita/presentation/pages/admin/calendar_page.dart';
import 'package:flutter_migaskita/presentation/pages/admin/activity_page.dart';
import 'package:flutter_migaskita/presentation/pages/admin/profile_page.dart';

class Routes {
  // Auth
  static const String login = '/login';
  static const String signUp = '/sign_up';

  // Employee
  static const String employeeHome = '/employee-home';
  static const String employeeCalendar = '/employee-calendar';
  static const String employeeActivity = '/employee-activity';
  static const String employeeProfile = '/employee-profile';

  // Admin
  static const String adminHome = '/admin-home';
  static const String adminCalendar = '/admin-calendar';
  static const String adminActivity = '/admin-activity';
  static const String adminProfile = '/admin-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      // Employee
      case employeeHome:
        return MaterialPageRoute(builder: (_) => EmployeeHomePage());
      case employeeCalendar:
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case employeeActivity:
        return MaterialPageRoute(builder: (_) => EmployeeActivityPage());
      case employeeProfile:
        return MaterialPageRoute(builder: (_) => EmployeeProfilePage());

      // Admin
      case adminHome:
        return MaterialPageRoute(builder: (_) => AdminHomePage());
      case adminCalendar:
        return MaterialPageRoute(builder: (_) => AdminCalendarPage());
      case adminActivity:
        return MaterialPageRoute(builder: (_) => AdminActivityPage());
      case adminProfile:
        return MaterialPageRoute(builder: (_) => AdminProfilePage());

      // Default
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
