part of 'pagination_bloc.dart';

@immutable
sealed class PaginationEvent {}

final class FetchPostEvent extends PaginationEvent{}

final class RetryFetchEvent extends PaginationEvent{}