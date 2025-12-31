// ignore_for_file: public_member_api_docs, sort_constructors_first
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
