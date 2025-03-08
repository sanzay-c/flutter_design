part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class FetchBlogEvent extends BlogEvent{}

class DeleteBlogPostEvent extends BlogEvent {
  final int id;

  DeleteBlogPostEvent({required this.id});
}
