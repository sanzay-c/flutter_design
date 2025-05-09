import 'dart:convert';
import 'dart:developer';

import 'package:new_app/data/models/blog_comment_model.dart';
import 'package:new_app/data/models/blog_model.dart';
import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:http/http.dart' as http;

class BlogRemoteDataSources {
  Future<List<BlogEntity>> fetchBlog() async {
    try {
      var blogUrl = 'http://10.0.2.2:8000/api/blog_post';

      final response = await http.get(Uri.parse(blogUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<BlogModel> blogData =
            jsonData.map((e) => BlogModel.fromJson(e)).toList();

        return blogData.map((blog) {
          return BlogEntity(
            id: blog.id,
            title: blog.title,
            content: blog.content,
            createdAt: blog.createdAt,
          );
        }).toList();
      } else {
        throw Exception("There is an Error in the data source");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<BlogCommentEntity>> fetchComment(int id) async {
    try {
      var commentUrl = 'http://10.0.2.2:8000/api/blog_post/$id/comments';

      final response = await http.get(Uri.parse(commentUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<BlogCommentModel> blogData =
            jsonData.map((e) => BlogCommentModel.fromJson(e)).toList();

        return blogData.map((blogComment) {
          return BlogCommentEntity(
            id: blogComment.id,
            name: blogComment.name,
            text: blogComment.text,
            createdAt: blogComment.createdAt,
            blogPost: blogComment.blogPost,
          );
        }).toList();
      } else {
        throw Exception("There is an Error in the data source");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<BlogModel> postBlog(BlogModel blogPost) async {
    try {
      var blogUrl = 'http://10.0.2.2:8000/api/blog_post';

      final response = await http.post(
        Uri.parse(blogUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(blogPost.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return BlogModel.fromJson(
            jsonData); //or you can do it like this as below
        // return json.decode(json.decode(response.body));
      } else {
        throw Exception("Failed to post blog: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error posting blog: $e");
    }
  }

  Future<BlogCommentModel> postBlogComment(BlogCommentModel postComment) async {
    try {
      var blogUrl =
          'http://10.0.2.2:8000/api/blog_post/${postComment.blogPost}/comments';

      final response = await http.post(
        Uri.parse(blogUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postComment.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return BlogCommentModel.fromJson(jsonData);
      } else {
        throw Exception("Failed to post comment: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error posting comment: $e");
    }
  }

  Future<void> deleteBlogPost(int id) async {
    try {
      var blogUrl = 'http://10.0.2.2:8000/api/blog_post/$id';

      final response = await http.delete(Uri.parse(blogUrl));

      if (response.statusCode != 204) {
        throw Exception("Failed to delete blog: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error deleting blog: $e");
    }
  }

  Future<void> deleteBlogPostComment(int blogPostId, int commentId) async {
    try {
      var commentUrl =
          'http://10.0.2.2:8000/api/blog_post/$blogPostId/comments/$commentId';

      final response = await http.delete(Uri.parse(commentUrl));

      if (response.statusCode != 204) {
        throw Exception(
            "Failed to delete blog comment: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error deleting blog comment: $e");
    }
  }

  Future<void> updateBlog(BlogEntity blog) async {
    try {
      var blogUrl = 'http://10.0.2.2:8000/api/blog_post/${blog.id}/update';

      final response = await http.put(
        Uri.parse(blogUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': blog.title,
          'content': blog.content,
          'created_at': blog.createdAt.toIso8601String(),
        }),
      );

      log("Response status code: ${response.statusCode}"); // Debugging
      log("Response body: ${response.body}"); // Debugging

      if (response.statusCode != 200) {
        throw Exception("Failed to update blog: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating blog: $e");
    }
  }
}
