import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('user_role');
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_phone');
    _user = null;
    notifyListeners();
  }

  /// ✅ Tambahan: load user dari SharedPreferences
  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    final name = prefs.getString('user_name');
    final phone = prefs.getString('user_phone');
    final email = prefs.getString('user_email');
    final role = prefs.getString('user_role');

    if (id != null &&
        name != null &&
        phone != null &&
        email != null &&
        role != null) {
      _user = User(id: id, name: name, phone: phone, email: email, role: role);
      notifyListeners();
    }
  }
}
