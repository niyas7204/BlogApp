import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.name, required super.id});
  factory UserModel.fromjson(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        id: map["id"] ?? '');
  }
}
