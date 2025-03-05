part of 'blog_comment_bloc.dart';

@immutable
abstract class BlogCommentEvent {}

class FetchBlogCommentEvent extends BlogCommentEvent{
  final int id; // ID for the blog post

  FetchBlogCommentEvent(this.id);
}

// refelect the change after the comment is posted
class AddBlogCommentEvent extends BlogCommentEvent {
  final BlogCommentEntity comment;

  AddBlogCommentEvent(this.comment);
}