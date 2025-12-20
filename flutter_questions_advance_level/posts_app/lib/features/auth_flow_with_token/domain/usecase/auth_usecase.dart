import 'package:posts_app/features/auth_flow_with_token/domain/entity/auth_entity.dart';
import 'package:posts_app/features/auth_flow_with_token/domain/repo/auth_repo.dart';

class AuthUsecase {
  final AuthRepo authRepo;

  AuthUsecase({required this.authRepo});

  Future<AuthEntity> call(String username, String password) async {
    return await authRepo.userAuth(username, password);
  }
}