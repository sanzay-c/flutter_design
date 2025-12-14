import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/core/config/env_config.dart';

@module 
abstract class NetworkModule {
  @lazySingleton 
  Dio get dio =>
      Dio(
          BaseOptions(
            baseUrl: EnvConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {"Content-Type": "application/json"},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print("Request: ${options.method} ${options.path}");
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
