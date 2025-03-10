part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class FetchBlogEvent extends BlogEvent{}

class DeleteBlogPostEvent extends BlogEvent {
  final int id;

  DeleteBlogPostEvent({required this.id});
}

// to update the blog
class UpdateBlogEvent extends BlogEvent {
  final BlogEntity blog;

  UpdateBlogEvent({required this.blog});
}