import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
