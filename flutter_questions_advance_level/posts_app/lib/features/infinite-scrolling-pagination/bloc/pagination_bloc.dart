import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/features/infinite-scrolling-pagination/api_services_post.dart';
import 'package:posts_app/features/infinite-scrolling-pagination/post_bloc.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final ApiServicesPost apiService;
  int page = 1;
  final int limit = 10;
  bool isFetching = false;

  PaginationBloc({required this.apiService}) : super(PaginationInitial()) {
    on<FetchPostEvent>(_onFetchPostEvent);
    on<RetryFetchEvent>(_onRetryFetchEvent);
  }

  FutureOr<void> _onFetchPostEvent(FetchPostEvent event, Emitter<PaginationState> emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      final currentState = state;

      if (currentState is PaginationInitial) {
        emit(PostsLoading());
        final posts = await apiService.fetchPosts(page: page, limit: limit);
        emit(PostsLoaded(posts: posts, hasReachedMax: posts.length < limit));
      } else if (currentState is PostsLoaded) {
        if (currentState.hasReachedMax) {
          isFetching = false;
          return;
        }

        page++;
        
        final posts = await apiService.fetchPosts(page: page, limit: limit);

        emit(posts.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : PostsLoaded(
                posts: List.of(currentState.posts)..addAll(posts),
                hasReachedMax: posts.length < limit,
              ));
      }
    } catch (e) {
      emit(PostsError(message: e.toString()));
    } finally {
      isFetching = false;
    }
  }

  FutureOr<void> _onRetryFetchEvent(RetryFetchEvent event, Emitter<PaginationState> emit) async {
    add(FetchPostEvent());
  }
}


