import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_migaskita/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_migaskita/data/datasources/remote/user_remote_data_source.dart';
import 'package:flutter_migaskita/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.userRemoteDataSource);

  @override
  Future<UserCredential> signIn(String email, String password) async {
    return await authRemoteDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
  }

  @override
  Future<UserCredential> signUp(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    final userCredential = await authRemoteDataSource
        .createUserWithEmailAndPassword(email, password);
    await userRemoteDataSource.setUserData(
      userCredential.user!.uid,
      name,
      phone,
      email,
      'employee', // Role default: employee
    );
    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await authRemoteDataSource.signOut();
  }
}
