part of 'api_handler_bloc.dart';

@immutable
sealed class ApiHandlerState {}

final class ApiHandlerInitial extends ApiHandlerState {}

final class ApiLoading extends ApiHandlerState {}

final class ApiLoaded extends ApiHandlerState {
  final List<Data> apiData;

  ApiLoaded({required this.apiData});
}

final class ApiError extends ApiHandlerState {
  final String errorMessage;

  ApiError({required this.errorMessage});
}