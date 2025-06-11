import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_migaskita/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<UserCredential> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
