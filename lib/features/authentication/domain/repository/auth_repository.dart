import 'dart:async';

import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, User>> currentUser();
}
