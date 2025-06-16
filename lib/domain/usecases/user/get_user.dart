import 'package:flutter_migaskita/domain/entities/user.dart';
import 'package:flutter_migaskita/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User> call(String uid) async {
    return await repository.getUserById(uid);
  }
}
