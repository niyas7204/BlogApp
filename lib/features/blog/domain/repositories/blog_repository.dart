import 'dart:io';

import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/features/blog/domain/entity/blog.dart';
import 'package:dartz/dartz.dart';

abstract class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required String userId,
    required String tittle,
    required String content,
    required List<String> topics,
    required File image,
  });
  Future<Either<Failure,List<Blog>>> getAllBlog();
}
