import 'package:flutter/material.dart';
import 'package:flutter_migaskita/domain/usecases/user/get_user.dart';
import '../../../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
