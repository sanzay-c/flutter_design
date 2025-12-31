import 'dart:convert';
import 'dart:io';

import 'package:posts_app/features/socket/data/models/message_model.dart';


class SocketDatasource {
  WebSocket? _socket;

  Stream<MessageModel> connect() async* {
    _socket = await WebSocket.connect('wss://echo.websocket.events');

    await for (final data in _socket!) {
      final decoded = jsonDecode(data);
      yield MessageModel.fromJson(decoded); //yield: It's like return, but it does not terminate the function; instead, it pauses the function's execution and maintains its state until the next value is requested. 
    }
  }

  void send(MessageModel model) {
    _socket?.add(jsonEncode(model.toJson()));
  }

  void disconnect() {
    _socket?.close();
  }
}
