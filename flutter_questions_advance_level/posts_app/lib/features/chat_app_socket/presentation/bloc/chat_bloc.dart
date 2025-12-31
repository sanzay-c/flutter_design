import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/core/socket/socket_service.dart';
import 'package:posts_app/features/chat_app_socket/data/message_model.dart';
import 'package:posts_app/features/chat_app_socket/presentation/bloc/chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SocketService socketService;
  late StreamSubscription _subscription;

  ChatBloc(this.socketService) : super(ChatInitial()) {
    on<ConnectSocket>(_onConnect);
    on<SendChatMessage>(_onSendMessage);
    on<ReceiveChatMessage>(_onReceiveMessage);
  }

  FutureOr<void> _onConnect(ConnectSocket event, Emitter<ChatState> emit) {
    socketService.connect();

    _subscription = socketService.stream.listen((event) {
      final decoded = jsonDecode(event);
      add(ReceiveChatMessage(decoded));
    });

    emit(ChatLoaded([]));
  }

  FutureOr<void> _onSendMessage(
    SendChatMessage event,
    Emitter<ChatState> emit,
  ) {
    socketService.sendMessage({
      'text': event.message,
      'sender': 'me',
    });
  }

  FutureOr<void> _onReceiveMessage(
    ReceiveChatMessage event,
    Emitter<ChatState> emit,
  ) {
    if (state is ChatLoaded) {
      final current = state as ChatLoaded;
      final msg = Message.fromJson(event.data);

      emit(ChatLoaded([...current.messages, msg]));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    socketService.disconnect();
    return super.close();
  }
}
