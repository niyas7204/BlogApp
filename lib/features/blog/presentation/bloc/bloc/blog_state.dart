part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

class BlogSuccess extends BlogState {
  final List<Blog> blog;

  BlogSuccess({required this.blog});
}

class BlogFailure extends BlogState {
  final String errorMessage;

  BlogFailure({required this.errorMessage});
}

class BloguploadSuccess extends BlogState {
  BloguploadSuccess();
}

final class BlogLoading extends BlogState {}
