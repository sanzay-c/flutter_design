part of 'blog_post_bloc.dart';

@immutable
abstract class BlogPostState {}

final class BlogPostInitial extends BlogPostState {}

final class BlogPostLoading extends BlogPostState {}

final class BlogPostSuccess extends BlogPostState {
  final BlogEntity blogPost;

  BlogPostSuccess({required this.blogPost});
}

final class BlogPostError extends BlogPostState {
  final String errorMessage;

  BlogPostError({required this.errorMessage});
}
