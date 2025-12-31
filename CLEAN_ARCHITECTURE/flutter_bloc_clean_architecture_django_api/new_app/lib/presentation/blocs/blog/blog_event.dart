part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class FetchBlogEvent extends BlogEvent{}

// class FetchBlogCommentEvent extends BlogEvent{
//   final int id; // ID for the blog post

//   FetchBlogCommentEvent(this.id);
// }