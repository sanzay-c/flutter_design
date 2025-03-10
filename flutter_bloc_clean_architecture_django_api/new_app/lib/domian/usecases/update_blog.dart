import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class UpdateBlog {
  final BlogRepository updateblogRepository;

  UpdateBlog({required this.updateblogRepository});

  Future<void> call(BlogEntity blog) async {
    return await updateblogRepository.updateBlog(blog);
  }
}