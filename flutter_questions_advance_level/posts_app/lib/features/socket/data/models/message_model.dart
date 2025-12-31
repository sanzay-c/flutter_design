import 'package:posts_app/features/socket/domain/entities/message_entity.dart';

class MessageModel {
  final String id;
  final String message;
  final bool isMine;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.isMine,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      isMine: json['isMine'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'isMine': isMine,
    'createdAt': createdAt.toIso8601String(),
  };

  MessageEntity toEntity() => MessageEntity(
    id: id,
    text: message,
    isMine: isMine,
    createdAt: createdAt,
  );
}
