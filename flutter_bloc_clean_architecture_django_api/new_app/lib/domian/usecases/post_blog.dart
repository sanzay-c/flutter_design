import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class PostBlog {
  final BlogRepository postRepository;

  PostBlog({required this.postRepository});

  Future<BlogEntity> call(BlogEntity postBlog) async {
    return await postRepository.createBlog(postBlog);
  }
}