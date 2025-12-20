part of 'adv_pagination_bloc.dart';

@immutable
sealed class AdvPaginationEvent {}

final class FetchNewsEvent extends AdvPaginationEvent {
}

final class RetryFetchNewsEvent extends AdvPaginationEvent {}

final class SearchNewsChanged extends AdvPaginationEvent {
  final String query;

  SearchNewsChanged(this.query);
}
