import 'dart:convert';

class BlogPostModel {
    int id;
    String title;
    String content;
    DateTime createdAt;

    BlogPostModel({
        required this.id,
        required this.title,
        required this.content,
        required this.createdAt,
    });

    BlogPostModel copyWith({
        int? id,
        String? title,
        String? content,
        DateTime? createdAt,
    }) => 
        BlogPostModel(
            id: id ?? this.id,
            title: title ?? this.title,
            content: content ?? this.content,
            createdAt: createdAt ?? this.createdAt,
        );

    factory BlogPostModel.fromRawJson(String str) => BlogPostModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BlogPostModel.fromJson(Map<String, dynamic> json) => BlogPostModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
    };
}
