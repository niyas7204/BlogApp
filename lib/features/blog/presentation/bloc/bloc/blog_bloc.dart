import 'dart:io';

import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/features/blog/domain/entity/blog.dart';
import 'package:cleanarchitecture/features/blog/domain/usercases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlog getAllBlog;
  BlogBloc(this.uploadBlog, this.getAllBlog) : super(BlogInitial()) {
    on<BlogEvent>(
      (event, emit) => emit(BlogLoading()),
    );
    on<BlogUpload>((event, emit) async {
      final res = await uploadBlog(UploadBlogParams(
          userId: event.userId,
          image: event.image,
          content: event.content,
          tittle: event.tittle,
          topics: event.topics));
      res.fold(
        (l) => emit(BlogFailure(errorMessage: l.message)),
        (r) => emit(BloguploadSuccess()),
      );
    });
    on<FetchAllBlogs>(
      (event, emit) async {
        final res = await getAllBlog(EmptyParams());
        res.fold(
          (l) => emit(BlogFailure(errorMessage: l.message)),
          (r) => emit(BlogSuccess(blog: r)),
        );
      },
    );
  }
}
