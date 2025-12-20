import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:posts_app/config/env_config.dart';
import 'package:posts_app/core/storage/secure_storage.dart';

@module
abstract class NetworkModule {
  @lazySingleton // Register Dio as singleton
  Dio get dio =>
      Dio(
          BaseOptions(
            // baseUrl: EnvConfig.apiBaseUrl,
            baseUrl: "https://api.escuelajs.co/",
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {"Content-Type": "application/json"},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await SecureStorage.getToken();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
            onResponse: (response, handler) {
              print("Response: ${response.statusCode}");
              return handler.next(response);
            },
            onError: (DioException e, handler) {
              print("Error: ${e.message}");
              return handler.next(e);
            },
          ),
        );
}
