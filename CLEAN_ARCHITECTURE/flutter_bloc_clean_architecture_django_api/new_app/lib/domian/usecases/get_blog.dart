import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class GetBlog {
  final BlogRepository repository;

  GetBlog({required this.repository});

  Future<List<BlogEntity>> call() async {
    return await repository.fetchBlog();
  }
}