import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/core/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CurrentUser implements Usecase<User, EmptyParams> {
  final AuthRepository authRepository;
  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(EmptyParams params) async {
    return await authRepository.currentUser();
  }
}
