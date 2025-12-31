import 'package:social_media_app/features/post/domain/entities/comment.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime timestamp;
  final List<String> likes; // store uids
  final List<Comment> comments; // for comments

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  // Factory constructor to create a Post from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      likes: List<String>.from(json['likes'] ?? []), // Handle null with empty list
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(Map<String, dynamic>.from(comment)))
          .toList() ?? [], // Handle null or empty comments
    );
  }

  // Method to convert a Post to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'likes': likes, // Include likes in JSON
      'comments': comments.map((comment) => comment.toJson()).toList(), // Convert comments to JSON
    };
  }

  // CopyWith method for creating a new instance with modified fields
  Post copyWith({
    String? id,
    String? userId,
    String? userName,
    String? text,
    String? imageUrl,
    DateTime? timestamp,
    List<String>? likes,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes, // Copy likes or default to existing list
      comments: comments ?? this.comments, // Copy comments or default to existing list
    );
  }
}
