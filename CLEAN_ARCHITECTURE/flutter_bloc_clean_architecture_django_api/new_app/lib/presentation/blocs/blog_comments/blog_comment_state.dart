part of 'blog_comment_bloc.dart';

@immutable
abstract class BlogCommentState {}

final class BlogCommentInitial extends BlogCommentState {}

final class BlogCommentLoading extends BlogCommentState {}

final class BlogCommentLoaded extends BlogCommentState {
  final List<BlogCommentEntity> blogComment;

  BlogCommentLoaded({required this.blogComment});
}

final class BlogCommentError extends BlogCommentState {
  final String errorMessage;

  BlogCommentError({required this.errorMessage});
}