import 'package:flutter/material.dart';
import 'package:posts_app/features/socket/domain/entities/message_entity.dart';

@immutable
sealed class SocketEvent {}

class ConnectSocket extends SocketEvent {}

class DisconnectSocket extends SocketEvent {}

class SendMessage extends SocketEvent {
  final MessageEntity message;
  SendMessage(this.message);
}

class MessageReceived extends SocketEvent {
  final MessageEntity message;
  MessageReceived(this.message);
}

class SocketErrorReceived extends SocketEvent {
  final String error;
  SocketErrorReceived(this.error);
}
