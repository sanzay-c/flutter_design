import 'package:posts_app/features/auth_flow_with_token/domain/entity/auth_entity.dart';

abstract class AuthRepo {
  Future<AuthEntity> userAuth(String username, String password);
}