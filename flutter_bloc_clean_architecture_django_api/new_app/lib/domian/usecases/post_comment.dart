import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class PostComment {
  final BlogRepository postRepository;

  PostComment({required this.postRepository});

  Future<BlogCommentEntity> call(BlogCommentEntity postComment) async {
    return await postRepository.addBlogComment(postComment);
  }
}
