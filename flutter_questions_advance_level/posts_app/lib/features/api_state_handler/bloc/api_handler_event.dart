part of 'api_handler_bloc.dart';

@immutable
sealed class ApiHandlerEvent extends Equatable{}

final class FetchData extends ApiHandlerEvent {
  @override
  List<Object?> get props => [];
}

final class RetryFetch extends ApiHandlerEvent {
  @override
  List<Object?> get props => [];
}
