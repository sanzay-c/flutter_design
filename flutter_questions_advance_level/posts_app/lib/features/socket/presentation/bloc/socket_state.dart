part of 'socket_bloc.dart';

@immutable
sealed class SocketState {}

final class SocketInitial extends SocketState {}

class SocketConnecting extends SocketState {}

class SocketConnected extends SocketState {
  final List<MessageEntity> messages;
  SocketConnected(this.messages);
}

class SocketDisconnected extends SocketState {}

class SocketError extends SocketState {
  final String error;
  SocketError(this.error);
}