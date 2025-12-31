part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

// final class BlogCommentLoading extends BlogState {}

final class BlogLoaded extends BlogState {
  final List<BlogEntity> blogs;

  BlogLoaded({required this.blogs});
}

// final class BlogCommentLoaded extends BlogState {
//   final List<BlogCommentEntity> blogComment;

//   BlogCommentLoaded({required this.blogComment});
// }

final class BlogError extends BlogState {
  final String errorMessage;

  BlogError({required this.errorMessage});
}

// final class BlogCommentError extends BlogState {
//   final String errorMessage;

//   BlogCommentError({required this.errorMessage});
// }
