import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectSocket extends ChatEvent {}

class SendChatMessage extends ChatEvent {
  final String message;
  SendChatMessage(this.message);
}

class ReceiveChatMessage extends ChatEvent {
  final Map<String, dynamic> data;
  ReceiveChatMessage(this.data);
}
