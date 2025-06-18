import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppColors {
  static const darkBlue = Color(0xFF0D1B4C);
  static const lightBlueBg = Color(0xFFF5F7FB);
  static const blurBlue = Color(0xFF0062FF);
}

class EmployeeActivityPage extends StatefulWidget {
  const EmployeeActivityPage({super.key});

  @override
  State<EmployeeActivityPage> createState() => _EmployeeActivityPageState();
}

class _EmployeeActivityPageState extends State<EmployeeActivityPage> {
  bool showHistory = false;
  int _selectedIndex = 2;
  bool _isInitialized = false;

  void _onNavBarTap(int index) {
    if (index == _selectedIndex) return;
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/employee-home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/employee-calendar');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/employee-profile');
    }
  }

  String get currentTime => DateFormat.Hm().format(DateTime.now());

  String get currentDate =>
      DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.lightBlueBg,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            height: 180,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: AppColors.blurBlue.withOpacity(0.12)),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Absensi",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.history),
                        onPressed: () {
                          setState(() {
                            showHistory = !showHistory;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4475EF), Color(0xFF6C9EFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Live Attendance",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentTime,
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentDate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C9EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Clock In"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Clock Out"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    showHistory ? "Riwayat Absen" : "Aktivitas",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (showHistory)
                    Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: const Text(
                        "Belum ada riwayat",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    Column(
                      children: [
                        _buildMenuTile(Icons.link, "Pengajuan Izin"),
                        const SizedBox(height: 12),
                        _buildMenuTile(Icons.description, "Pengajuan Cuti"),
                        const SizedBox(height: 12),
                        _buildMenuTile(Icons.mail, "Hasil"),
                      ],
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

  Widget _buildMenuTile(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkBlue),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: AppColors.darkBlue),
          ),
        ],
      ),
    );
  }
}
