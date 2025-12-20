import 'package:posts_app/features/auth_flow_with_token/data/datasource/auth_datasource.dart';
import 'package:posts_app/features/auth_flow_with_token/domain/entity/auth_entity.dart';
import 'package:posts_app/features/auth_flow_with_token/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDatasource authDatasource;

  AuthRepoImpl(this.authDatasource);
  
  @override
  Future<AuthEntity> userAuth(String email, String password) async {
    final model = await authDatasource.userAuth(email: email, password: password);
    return model.toEntity();
  }
}