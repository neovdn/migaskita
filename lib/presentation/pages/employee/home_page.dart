import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:flutter_migaskita/presentation/providers/user_provider.dart';

class AppColors {
  static const darkBlue = Color(0xFF0D1B4C);
  static const lightBlueBg = Color(0xFFF5F7FB);
  static const blurBlue = Color(0xFF0062FF);
}

class EmployeeHomePage extends StatefulWidget {
  @override
  _EmployeeHomePageState createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    if (index == 0)
      return;
    else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/employee-calendar');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/employee-activity');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/employee-profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final userName = user?.name ?? 'User';

    return Scaffold(
      backgroundColor: AppColors.lightBlueBg,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
      body: Stack(
        children: [
          // BACKGROUND BLUR BIRU: dari tengah jadwal ke atas
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            height: 105,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: AppColors.blurBlue.withOpacity(0.12)),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selamat datang,\n$userName',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Jadwal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      Text('View All', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4475EF), Color(0xFF6C9EFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Jadwal dummy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.description,
                          size: 28,
                          color: AppColors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pengajuan Cuti',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Pengumuman',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.notifications,
                          size: 28,
                          color: AppColors.darkBlue,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Tenggat Cuti hingga 30/06/2025',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.darkBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
