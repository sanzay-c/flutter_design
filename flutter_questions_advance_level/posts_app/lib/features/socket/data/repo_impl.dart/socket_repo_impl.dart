
import 'package:posts_app/features/socket/data/datasource/socket_datasource.dart';
import 'package:posts_app/features/socket/data/models/message_model.dart';
import 'package:posts_app/features/socket/domain/entities/message_entity.dart';
import 'package:posts_app/features/socket/domain/repo/socket_repo.dart';
import 'package:uuid/uuid.dart';

class SocketRepoImpl implements SocketRepo {
  final SocketDatasource datasource;

  SocketRepoImpl(this.datasource);

  @override
  Stream<MessageEntity> connect() {
    return datasource.connect().map((m) => m.toEntity());
  }

  @override
  void sendMessage(String text) {
    final model = MessageModel(
      id: const Uuid().v4(),
      message: text,
      isMine: true,
      createdAt: DateTime.now(),
    );
    datasource.send(model);
  }

  @override
  void disconnect() {
    datasource.disconnect();
  }
}
