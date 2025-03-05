part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentEvent {}

final class BlogPostCommentEvent extends PostCommentEvent {
  final BlogCommentEntity postComment;
  
  BlogPostCommentEvent({required this.postComment});
}