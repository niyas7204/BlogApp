import 'package:cleanarchitecture/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  });
}
