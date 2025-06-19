import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/shared/shared_home_page.dart';
import 'package:flutter_migaskita/presentation/providers/user_provider.dart';

class EmployeeHomePage extends StatefulWidget {
  @override
  _EmployeeHomePageState createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    if (index == 0) return;
    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/employee-calendar');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/employee-activity');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/employee-profile');
    }
  }

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    debugPrint('📌 Masuk HomePage, user: $user');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final userName = user?.name ?? 'User';

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onNavBarTap,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              height: 105,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    color: const Color(0xFF0062FF).withOpacity(0.12),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SharedHomePage(
                  userName: userName,
                  role: 'employee',
                  onNavToCalendar:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/employee-calendar',
                      ),
                  onNavToActivity:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/employee-activity',
                      ),
                  onNavToProfile:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/employee-profile',
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
