import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/features/authentication/domain/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.login(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;

  final String password;
  UserLoginParams(this.email, this.password);
}
