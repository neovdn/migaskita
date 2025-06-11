import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_migaskita/core/errors/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<void> setUserData(
    String uid,
    String name,
    String phone,
    String email,
    String role,
  );
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> setUserData(
    String uid,
    String name,
    String phone,
    String email,
    String role,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException();
    }
  }
}
