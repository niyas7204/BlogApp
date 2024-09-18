import 'dart:developer';

import 'package:cleanarchitecture/core/errors/exceptions.dart';
import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:cleanarchitecture/features/authentication/data/models/user_model.dart';
import 'package:cleanarchitecture/features/authentication/domain/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImplimentation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImplimentation({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    return _getuser(
      () async =>
          await remoteDataSource.login(email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    return _getuser(
      () async => await remoteDataSource.signUp(
          email: email, password: password, name: name),
    );
  }

  Future<Either<Failure, User>> _getuser(
      Future<User> Function() authFunction) async {
    try {
      final user = await authFunction();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.errorMessage));
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    }
  }
}
