import 'dart:async';

import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/state_handler.dart';
import 'package:cleanarchitecture/features/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String name,
  });
}
