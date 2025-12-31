import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  late WebSocketChannel _channel;

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.org'),
    );
  }

  Stream<dynamic> get stream => _channel.stream;

  void sendMessage(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void disconnect() {
    _channel.sink.close();
  }
}
