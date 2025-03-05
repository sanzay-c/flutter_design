import 'dart:convert';

class BlogCommentModel {
    int id;
    String name;
    String text;
    DateTime createdAt;
    int blogPost;

    BlogCommentModel({
        required this.id,
        required this.name,
        required this.text,
        required this.createdAt,
        required this.blogPost,
    });

    BlogCommentModel copyWith({
        int? id,
        String? name,
        String? text,
        DateTime? createdAt,
        int? blogPost,
    }) => 
        BlogCommentModel(
            id: id ?? this.id,
            name: name ?? this.name,
            text: text ?? this.text,
            createdAt: createdAt ?? this.createdAt,
            blogPost: blogPost ?? this.blogPost,
        );

    factory BlogCommentModel.fromRawJson(String str) => BlogCommentModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BlogCommentModel.fromJson(Map<String, dynamic> json) => BlogCommentModel(
        id: json["id"],
        name: json["name"],
        text: json["text"],
        createdAt: DateTime.parse(json["created_at"]),
        blogPost: json["blog_post"],
    );

  get title => null;

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "text": text,
        "created_at": createdAt.toIso8601String(),
        "blog_post": blogPost,
    };
}
