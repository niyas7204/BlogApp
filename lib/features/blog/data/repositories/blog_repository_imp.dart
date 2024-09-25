import 'dart:io';

import 'package:cleanarchitecture/core/errors/exceptions.dart';
import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/core/network/connection_checker.dart';
import 'package:cleanarchitecture/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:cleanarchitecture/features/blog/data/data_sources/blog_remote_data_sources.dart';
import 'package:cleanarchitecture/features/blog/data/models/blog.dart';
import 'package:cleanarchitecture/features/blog/domain/entity/blog.dart';
import 'package:cleanarchitecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplimentation implements BlogRepository {
  final BlogRemoteDataSources blogRemoteDataSources;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImplimentation({
    required this.blogLocalDataSource,
    required this.blogRemoteDataSources,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String userId,
      required String tittle,
      required String content,
      required List<String> topics,
      required File image}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("network not found"));
      }
      BlogModel blog = BlogModel(
          userId: userId,
          blogId: const Uuid().v1(),
          tittle: tittle,
          content: content,
          topics: topics,
          imageUrl: "",
          updatedAt: DateTime.now());
      final url =
          await blogRemoteDataSources.uploadImage(image: image, blog: blog);
      blog = blog.copyWith(imageUrl: url);
      final uploadedBlog =
          await blogRemoteDataSources.uploadBlog(newBlog: blog);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.errorMessage));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadLocalBlog();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSources.getAllBlog();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
