part of 'adv_pagination_bloc.dart';

@immutable
sealed class AdvPaginationState {}

final class AdvPaginationInitial extends AdvPaginationState {}

final class AdvPaginationLoading extends AdvPaginationState {}

final class AdvPaginationLoaded extends AdvPaginationState {
  final List<News> news;
  final bool hasReachedMax;

  AdvPaginationLoaded({required this.news, required this.hasReachedMax});

  AdvPaginationLoaded copyWith({
    List<News>? news, 
    bool? hasReachedMax
  }) {
    return AdvPaginationLoaded(
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class AdvPaginationError extends AdvPaginationState {
  final String errorMessage;

  AdvPaginationError({required this.errorMessage});
}

final class AdvPaginationCached extends AdvPaginationState {
  final List<News> news;

  AdvPaginationCached(this.news);
}
