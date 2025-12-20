part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AppStartedEvent extends AuthEvent {}

final class LoginRequestedEvent extends AuthEvent{
  final String usernmae;
  final String password;

  LoginRequestedEvent({required this.usernmae, required this.password});
}

final class LogOutRequestedEvent extends AuthEvent {}