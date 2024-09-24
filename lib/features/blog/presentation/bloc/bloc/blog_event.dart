part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String userId;
  final File image;
  final String content;
  final String tittle;
  final List<String> topics;

  BlogUpload(
      {required this.userId,
      required this.image,
      required this.content,
      required this.tittle,
      required this.topics});
}

final class FetchAllBlogs extends BlogEvent {}
