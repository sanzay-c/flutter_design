import 'package:new_app/domian/repositories/blog_repository.dart';

class DeleteBlogComment {
  final BlogRepository blogRepositoryDeleteComment;

  DeleteBlogComment({required this.blogRepositoryDeleteComment});

  Future<void> call(int blogPostId, int commentId) async {
    return await blogRepositoryDeleteComment.deleteBlogComment(blogPostId, commentId);
  }
}