part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogLoaded extends BlogState {
  final List<BlogEntity> blogs;

  BlogLoaded({required this.blogs});
}

final class BlogError extends BlogState {
  final String errorMessage;

  BlogError({required this.errorMessage});
}
