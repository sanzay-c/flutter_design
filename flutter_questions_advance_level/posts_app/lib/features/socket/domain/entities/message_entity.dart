class MessageEntity {
  final String id;
  final String text;
  final bool isMine;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.text,
    required this.isMine,
    required this.createdAt,
  });
}
