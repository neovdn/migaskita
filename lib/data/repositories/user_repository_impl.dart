import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl({required this.firestore});

  @override
  Future<domain.User> getUserById(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return UserModel.fromJson(doc.data()!).toEntity();
  }

  @override
  Future<void> updateUser(domain.User user) async {
    final model = UserModel.fromEntity(user);
    await firestore.collection('users').doc(user.id).update(model.toJson());
  }
}
