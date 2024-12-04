import 'dart:convert';

import 'package:api_view_project/models/blog_comment_model.dart';
import 'package:api_view_project/models/blog_post_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // GET the data form the blog post
  Future<List<BlogPostModel>> fetchBlogPost() async {
    try {
      const baseUrl = 'http://10.0.2.2:8000/api/blog_post';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = json.decode(response.body);
        List<BlogPostModel> blogList =
            jsonData.map((e) => BlogPostModel.fromJson(e)).toList();

        return blogList;
      } else {
        throw Exception("Failed to load the data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // POST the data to the blog post
  Future<BlogPostModel> postBlog(BlogPostModel blogPost) async {
    try {
      const baseUrl = 'http://10.0.2.2:8000/api/blog_post';

      // Make POST request to the server with the blog post data
      final response = await http.post(
        Uri.parse(baseUrl),
        // Indicating the data is in JSON format
        headers: {'Content-Type': 'application/json'},
        // Convert the blog post to JSON
        body: json.encode(blogPost.toJson()),
      );

      if (response.statusCode == 201) {
        // If the response is successful (201 Created), parse the response
        return BlogPostModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create the blog post');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // GET the data from the blog post
  Future<List<BlogCommentModel>> getComments(int id) async {
    try {
      final baseUrl = 'http://10.0.2.2:8000/api/blog_post/$id/comments';
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<BlogCommentModel> blogComment =
            jsonData.map((e) => BlogCommentModel.fromJson(e)).toList();

        return blogComment;
      } else {
        throw Exception("Error occured");
      }
    } catch (e) {
      throw Exception("Error Occured: $e");
    }
  }

  // POST the data to the blog post
  Future<BlogCommentModel> postComment(BlogCommentModel comment) async {
    try {
      final baseUrl =
          'http://10.0.2.2:8000/api/blog_post/${comment.blogPost}/comments';
      // Make POST request to the server with the blog post data
      final response = await http.post(
        Uri.parse(baseUrl),
        // Indicating the data is in JSON format
        headers: {'Content-Type': 'application/json'},
        // Convert the comment to JSON
        body: json.encode(comment.toJson()),
      );

      if (response.statusCode == 201) {
        // If the response is successful (201 Created), parse the response
        final Map<String, dynamic> data = json.decode(response.body);
        return BlogCommentModel.fromJson(data);
      } else {
        throw Exception('Failed to create the comment');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
