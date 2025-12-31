part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

// loading ..
final class AuthLoading extends AuthState{}

// Authenticated
final class Authenticated extends AuthState{
  final AppUser user;
  Authenticated(this.user);
}

// UnAuthenticated
final class UnAuthenticated extends AuthState{}

// Error states
final class AuthError extends AuthState{
  final String message;
  AuthError(this.message);
}