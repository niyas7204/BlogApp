import 'dart:io';

import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/features/blog/domain/entity/blog.dart';
import 'package:cleanarchitecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:dartz/dartz.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        userId: params.userId,
        tittle: params.tittle,
        content: params.content,
        topics: params.topics,
        image: params.image);
  }
}

class GetAllBlog extends Usecase<List<Blog>, EmptyParams> {
  final BlogRepository blogRepository;

  GetAllBlog({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(EmptyParams params) {
    return blogRepository.getAllBlog();
  }
}

class UploadBlogParams {
  final String userId;
  final File image;
  final String content;
  final String tittle;
  final List<String> topics;

  UploadBlogParams(
      {required this.userId,
      required this.image,
      required this.content,
      required this.tittle,
      required this.topics});
}
