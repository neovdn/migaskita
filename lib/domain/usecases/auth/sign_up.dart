import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_migaskita/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<UserCredential> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await repository.signUp(email, password, name, phone);
  }
}
