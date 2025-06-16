import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    role: json['role'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'role': role,
  };

  User toEntity() =>
      User(id: id, name: name, phone: phone, email: email, role: role);

  static UserModel fromEntity(User user) => UserModel(
    id: user.id,
    name: user.name,
    phone: user.phone,
    email: user.email,
    role: user.role,
  );
}
