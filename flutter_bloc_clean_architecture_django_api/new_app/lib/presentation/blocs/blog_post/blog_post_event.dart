part of 'blog_post_bloc.dart';

@immutable
abstract class BlogPostEvent {}

final class PostEvent extends BlogPostEvent {
  final BlogEntity blogPost;

  PostEvent({required this.blogPost});
}
