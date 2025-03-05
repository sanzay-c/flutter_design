class BlogEntity {
  int id;
  String title;
  String content;
  DateTime createdAt;

  BlogEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
