import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/repositories/blog_repository.dart';

class GetComment {
  final BlogRepository commentrepository;

  GetComment({required this.commentrepository});

  Future<List<BlogCommentEntity>> call(int id) async {
    return await commentrepository.fetchComment(id);
  }
}