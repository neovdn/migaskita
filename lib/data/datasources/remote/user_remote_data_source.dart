import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_migaskita/core/errors/exceptions.dart';
import 'package:flutter_migaskita/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> setUserData(
    String uid,
    String name,
    String phone,
    String email,
    String role,
  );

  Future<UserModel?> getUserData(String uid); // <<--- Tambahan
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

  @override
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson({'id': doc.id, ...doc.data()!});
      }
      return null;
    } catch (e) {
      throw ServerException();
    }
  }
}
