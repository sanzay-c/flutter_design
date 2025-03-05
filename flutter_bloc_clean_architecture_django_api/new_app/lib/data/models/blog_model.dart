import 'dart:convert';

class BlogModel {
    int id;
    String title;
    String content;
    DateTime createdAt;

    BlogModel({
        required this.id,
        required this.title,
        required this.content,
        required this.createdAt,
    });

    BlogModel copyWith({
        int? id,
        String? title,
        String? content,
        DateTime? createdAt,
    }) => 
        BlogModel(
            id: id ?? this.id,
            title: title ?? this.title,
            content: content ?? this.content,
            createdAt: createdAt ?? this.createdAt,
        );

    factory BlogModel.fromRawJson(String str) => BlogModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
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
