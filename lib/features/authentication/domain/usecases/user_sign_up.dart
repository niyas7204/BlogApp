import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/features/authentication/domain/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
        email: params.email, password: params.password, name: params.name);
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;
  UserSignUpParams(this.email, this.name, this.password);
}
