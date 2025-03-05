part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentState {}

final class PostCommentInitial extends PostCommentState {}

final class PostCommentLoading extends PostCommentState {}

final class PostCommentSuccess extends PostCommentState {
  final BlogCommentEntity postComment;

  PostCommentSuccess({required this.postComment});
}

final class PostCommentError extends PostCommentState {
  final String errorMessage;

  PostCommentError({required this.errorMessage});
}
