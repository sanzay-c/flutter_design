import 'package:new_app/data/datasources/blog_remote_data_sources.dart';
import 'package:new_app/data/models/blog_comment_model.dart';
import 'package:new_app/data/models/blog_model.dart';
import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSources dataSources;

  BlogRepositoryImpl({required this.dataSources});

  @override
  Future<List<BlogEntity>> fetchBlog() async {
    return await dataSources.fetchBlog();
  }

  @override
  Future<List<BlogCommentEntity>> fetchComment(int id) async {
    return await dataSources.fetchComment(id);
  }

  @override
  Future<BlogEntity> createBlog(BlogEntity blogPost) async {
    try {
      // convert blogEntity to blogModel
      final blogModel = BlogModel(
        id: blogPost.id,
        title: blogPost.title,
        content: blogPost.content,
        createdAt: blogPost.createdAt,
      );

      // call the data source
      final createdBlogModel = await dataSources.postBlog(blogModel);

      // convert blogmodel back to blogentity
      return BlogEntity(
        id: createdBlogModel.id,
        title: createdBlogModel.title,
        content: createdBlogModel.content,
        createdAt: createdBlogModel.createdAt,
      );
    } catch (e) {
      throw Exception("Error in the repository: $e");
    }
  }

  @override
  Future<BlogCommentEntity> addBlogComment(BlogCommentEntity postComment) async {
    try {
      // convert blogCommentEntity to blogCommentModel
      final blogCommentModel = BlogCommentModel(
        id: postComment.id,
        name: postComment.name,
        text: postComment.text,
        createdAt: postComment.createdAt,
        blogPost: postComment.blogPost,
      );

      // call the data source
      final createdBlogCommentModel =
          await dataSources.postBlogComment(blogCommentModel);

      // convert blogcommentmodel back to blogcommententity
      return BlogCommentEntity(
        id: createdBlogCommentModel.id,
        name: createdBlogCommentModel.name,
        text: createdBlogCommentModel.text,
        createdAt: createdBlogCommentModel.createdAt,
        blogPost: createdBlogCommentModel.blogPost,
      );
    } catch (e) {
      throw Exception("Error in the repository: $e");
    }
  }
  
  @override
  Future<void> deleteBlog(int id) async {
    return await dataSources.deleteBlogPost(id);
  }
  
  @override
  Future<void> deleteBlogComment(int blogPostId, int commentId) async {
    return await dataSources.deleteBlogPostComment(blogPostId, commentId);
  }
  
  @override
  Future<void> updateBlog(BlogEntity blog) async {
    return await dataSources.updateBlog(blog);
  }
}
