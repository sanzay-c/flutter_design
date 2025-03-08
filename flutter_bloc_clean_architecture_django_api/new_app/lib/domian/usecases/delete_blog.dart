import 'package:new_app/domian/repositories/blog_repository.dart';

class DeleteBlog {
  final BlogRepository blogRepositoryDelete;

  DeleteBlog({required this.blogRepositoryDelete});

  Future<void> call(int id) async {
    return await blogRepositoryDelete.deleteBlog(id);
  }
}