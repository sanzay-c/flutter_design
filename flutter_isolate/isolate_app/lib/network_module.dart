import 'package:dio/dio.dart';

abstract class NetworkModule {
  Dio dio() => Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com",
     headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          receiveTimeout: Duration(seconds: 10),
          connectTimeout: Duration(seconds: 10)
    )
  );
}