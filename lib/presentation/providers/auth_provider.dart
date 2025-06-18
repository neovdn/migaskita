import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_in.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_up.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_out.dart';
import 'package:flutter_migaskita/domain/usecases/user/get_user.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AuthProvider extends ChangeNotifier {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final GetUser getUser;

  User? _user;

  AuthProvider(this.signIn, this.signUp, this.signOut, this.getUser);

  User? get user => _user;

  Future<bool> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await signIn(email, password);
      _user = userCredential.user;
      notifyListeners();

      final userData = await getUser(_user!.uid);

      Provider.of<UserProvider>(context, listen: false).setUser(userData);

      // 🔥 Navigasi berdasarkan role
      if (userData.role == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin-home');
      } else {
        Navigator.pushReplacementNamed(context, '/employee-home');
      }

      return true;
    } catch (e) {
      print('LOGIN ERROR: $e');
      _user = null;
      notifyListeners();
      return false;
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final userCredential = await signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Sign-up failed: $e');
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    await signOut();
    _user = null;
    Provider.of<UserProvider>(context, listen: false).clearUser();
    notifyListeners();
  }
}
