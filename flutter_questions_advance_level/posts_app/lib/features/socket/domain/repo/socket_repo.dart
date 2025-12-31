import 'package:posts_app/features/socket/domain/entities/message_entity.dart';

abstract class SocketRepo {
  Stream<MessageEntity> connect();
  void sendMessage(String text);
  void disconnect();
}
