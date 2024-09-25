import 'dart:developer';
import 'dart:io';

import 'package:cleanarchitecture/core/errors/exceptions.dart';
import 'package:cleanarchitecture/core/network/connection_checker.dart';
import 'package:cleanarchitecture/features/blog/data/models/blog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog({required BlogModel newBlog});
  Future<String> uploadImage({required File image, required BlogModel blog});
  Future<List<BlogModel>> getAllBlog();
}

class BlogRemoteDatasourceImp implements BlogRemoteDataSources {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImp({
    required this.supabaseClient,
  });

  @override
  Future<BlogModel> uploadBlog({required BlogModel newBlog}) async {
    try {
      log("update started");
      final blog =
          await supabaseClient.from('blog').insert(newBlog.tojson()).select();
      log("to json complete");
      return BlogModel.fromJson(blog.first);
    } catch (e) {
      log("upload blog error $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage
          .from('blog_image')
          .upload(blog.blogId, image);

      return supabaseClient.storage
          .from('blog_image')
          .getPublicUrl(blog.blogId);
    } catch (e) {
      log("upload image error $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogs =
          await supabaseClient.from('blog').select("*,profiles (name)");
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog)
                .copyWith(blogName: blog['profiles']['name']),
          )
          .toList();
    } catch (e) {
      log("get all blog erro $e");
      throw ServerException(e.toString());
    }
  }
}
