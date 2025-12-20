part of 'pagination_bloc.dart';

@immutable
sealed class PaginationState {}

final class PaginationInitial extends PaginationState {}

// Loading first page
final class PostsLoading extends PaginationState {}

// Loaded posts
final class PostsLoaded extends PaginationState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostsLoaded({required this.posts, required this.hasReachedMax});

  @override
  List<Object?> get props => [posts, hasReachedMax];

  // Helper for copyWith
  PostsLoaded copyWith({
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

// Error state
final class PostsError extends PaginationState {
  final String message;

  PostsError({required this.message});

  @override
  List<Object?> get props => [message];
}
