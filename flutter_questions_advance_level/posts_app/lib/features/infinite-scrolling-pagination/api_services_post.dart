import 'dart:async';

import 'package:posts_app/features/infinite-scrolling-pagination/post_bloc.dart';


class ApiServicesPost {
  Future<List<Post>> fetchPosts({required int page, int limit = 10}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (page > 5) return []; // simulate end of pages

    return List.generate(limit, (index) {
      final id = (page - 1) * limit + index; // It calculates the post id based on the page number and index (for example, page 1 will have posts with ids 1 to 10, page 2 will have ids 11 to 20).
      return Post(
        id: id,
        title: "Post $id",
        content: "Content of post $id",
      );
    });

    // Uncomment to simulate error
    // throw Exception("Network error");
  }
}
