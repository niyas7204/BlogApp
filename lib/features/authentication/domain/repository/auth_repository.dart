import 'dart:async';

import 'package:cleanarchitecture/core/state_handler.dart';

abstract class AuthRepository {
  Future<StateHandler<String>> login(
      {required String email, required String password});
  Future<StateHandler<String>> signUp({
    required String email,
    required String password,
    required String name,
  });
}
