part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthenticatedSate extends AuthState {
  final AuthEntity auth;

  AuthenticatedSate(this.auth);
}

final class UnauthenticatedState extends AuthState {
}

final class AuthFailureState extends AuthState {
  final String error;

  AuthFailureState({required this.error});
}