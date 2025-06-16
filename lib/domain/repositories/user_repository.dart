import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String uid);
  Future<void> updateUser(User user);
}
