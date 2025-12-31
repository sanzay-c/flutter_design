part of 'post_cubit.dart';

@immutable
abstract class PostState {}

// initial
class PostInitial extends PostState {}

// loading..
class PostsLoading extends PostState {}

// uploading..
class PostsUploading extends PostState {}

// error
class PostsError extends PostState {
  final String message;
  PostsError(this.message);
}

// loaded
class PostsLoaded extends PostState{
  final List<Post> posts;
  PostsLoaded(this.posts);
}
