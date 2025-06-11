import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_in.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_up.dart';
import 'package:flutter_migaskita/domain/usecases/auth/sign_out.dart';

class AuthProvider extends ChangeNotifier {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  User? _user;

  AuthProvider(this.signIn, this.signUp, this.signOut);

  User? get user => _user;

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await signIn(email, password);
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
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

  Future<void> signOutUser() async {
    await signOut();
    _user = null;
    notifyListeners();
  }
}
