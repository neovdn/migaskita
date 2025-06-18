import 'package:flutter/material.dart';

class SharedHomePage extends StatelessWidget {
  final String userName;
  final String role; // "admin" atau "employee"
  final VoidCallback onNavToCalendar;
  final VoidCallback onNavToActivity;
  final VoidCallback onNavToProfile;

  const SharedHomePage({
    required this.userName,
    required this.role,
    required this.onNavToCalendar,
    required this.onNavToActivity,
    required this.onNavToProfile,
  });

  Widget _buildMenuTile(IconData icon, String label) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 6),
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Color(0xFF0D1B4C)),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0D1B4C),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActivityMenu() {
    if (role == 'admin') {
      return [
        _buildMenuTile(Icons.list_alt, "Lihat Absensi"),
        const SizedBox(width: 12),
        _buildMenuTile(Icons.schedule, "Atur Jadwal"),
        const SizedBox(width: 12),
        _buildMenuTile(Icons.check_circle, "Persetujuan"),
      ];
    } else {
      return [
        _buildMenuTile(Icons.link, "Pengajuan Izin"),
        const SizedBox(width: 12),
        _buildMenuTile(Icons.description, "Pengajuan Cuti"),
        const SizedBox(width: 12),
        _buildMenuTile(Icons.mail, "Hasil"),
      ];
    }
  }

  String _announcementText() {
    return role == 'admin'
        ? '2 perizinan belum disetujui'
        : 'Tenggat Cuti hingga 30/06/2025';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                color: Color(0xFF0D1B4C),
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
                color: Color(0xFF0D1B4C),
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
            color: Color(0xFF0D1B4C),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _buildActivityMenu()),
        ),
        const SizedBox(height: 24),
        const Text(
          'Pengumuman',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D1B4C),
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
            children: [
              const Icon(
                Icons.notifications,
                size: 28,
                color: Color(0xFF0D1B4C),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _announcementText(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0D1B4C),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
