import 'dart:developer';

import 'package:cleanarchitecture/core/errors/exceptions.dart';
import 'package:cleanarchitecture/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:cleanarchitecture/features/authentication/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteImplimentation implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteImplimentation(this.supabaseClient);
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      log("login ------ ${response.user}");
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromjson(response.user!.toJson());
    } catch (e) {
      log("login ------ error $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {"name": name});
      log("signup------ $response");
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromjson(response.user!.toJson());
    } catch (e) {
      log("signup------ error $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq("id", currentSession!.user.id);
      return UserModel.fromjson(userData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
