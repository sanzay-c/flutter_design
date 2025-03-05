class BlogCommentEntity {
  int id;
  String name;
  String text;
  DateTime createdAt;
  int blogPost;

  BlogCommentEntity({
    required this.id,
    required this.name,
    required this.text,
    required this.createdAt,
    required this.blogPost,
  });
}
