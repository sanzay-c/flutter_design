import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/features/socket/domain/entities/message_entity.dart';
import 'package:posts_app/features/socket/domain/repo/socket_repo.dart';
import 'package:posts_app/features/socket/presentation/bloc/socket_event.dart';

part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final SocketRepo repo;
  StreamSubscription? _subscription;

  final List<MessageEntity> _messages = [];
  final Set<String> _messageIds = {};

  SocketBloc(this.repo) : super(SocketInitial()) {
    on<ConnectSocket>(_connect);
    on<SendMessage>(_send);
    on<MessageReceived>(_onMessage);
    on<SocketErrorReceived>(_onError);
    on<DisconnectSocket>(_disconnect);
  }

  FutureOr<void> _connect(
    ConnectSocket event,
    Emitter<SocketState> emit,
  ) async {
    emit(SocketConnecting());

    _subscription = repo.connect().listen(
      (message) {
        add(MessageReceived(message));
      },
      onError: (e) {
        add(SocketErrorReceived(e.toString()));
      },
    );
  }

  FutureOr<void> _send(SendMessage event, Emitter<SocketState> emit) {
    repo.sendMessage(event.message.id);
  }

  FutureOr<void> _onMessage(
    MessageReceived event,
    Emitter<SocketState> emit,
  ) {
    if (_messageIds.contains(event.message.id));

    _messageIds.add(event.message.id);
    _messages.add(event.message);

    emit(SocketConnected(List.from(_messages)));
  }

  FutureOr<void> _onError(
    SocketErrorReceived event,
    Emitter<SocketState> emit,
  ) {
    emit(SocketError(event.error));
  }

  FutureOr<void> _disconnect(
    DisconnectSocket event,
    Emitter<SocketState> emit,
  ) async {
    await _subscription?.cancel();
    repo.disconnect();
    emit(SocketDisconnected());
  }
}
