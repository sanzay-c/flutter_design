import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/entities/blog_entity.dart';

abstract class BlogRepository {
  Future<List<BlogEntity>> fetchBlog();
  Future<List<BlogCommentEntity>> fetchComment(int id);
  Future<BlogEntity> createBlog(BlogEntity blogPost);
  Future<BlogCommentEntity> addBlogComment(BlogCommentEntity postComment);
  Future<void> deleteBlog(int id);
  Future<void> deleteBlogComment(int blogPostId, int commentId);
  Future<void> updateBlog(BlogEntity blog);
}