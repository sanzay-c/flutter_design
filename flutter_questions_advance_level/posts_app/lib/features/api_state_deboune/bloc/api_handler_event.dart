part of 'api_handler_bloc.dart';

@immutable
sealed class ApiHandlerEvent {}

final class SearchTextChanged extends ApiHandlerEvent {
  final String query;

  SearchTextChanged({required this.query});
}

