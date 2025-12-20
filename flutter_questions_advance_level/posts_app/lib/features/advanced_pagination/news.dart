class News {
  final int id;
  final String title;
  final String content;

  News({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
      };

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
