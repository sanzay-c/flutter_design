  import 'package:dio/dio.dart';
  import 'package:posts_app/features/auth_flow_with_token/data/models/auth_model.dart';

  class AuthDatasource {
    final Dio _dio;

    AuthDatasource(this._dio);

    Future<AuthModel> userAuth({
      required String email,
      required String password,
    }) async {
      try {
        final response = await _dio.post(
          'api/v1/auth/login',
          data: {'email': email, 'password': password},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return AuthModel.fromJson(response.data);
        } else {
          throw Exception('Authentication failed: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception("Error: $e");
      }
    }
  }
