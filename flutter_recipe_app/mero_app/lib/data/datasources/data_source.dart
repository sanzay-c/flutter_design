// import 'package:dio/dio.dart';
// import 'package:mero_app/config/env_config.dart';
// import 'package:mero_app/data/models/recipe_model.dart';

// class RecipeDatasource {
//   static final String hostUrl = EnvConfig.apiBaseUrl;

//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: hostUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {
//         "Content-Type": "application/json",
//       },
//     ),
//   )..interceptors.add(InterceptorsWrapper( // here double dot is the cascade operator, It allows you to perform multiple operations on the same object.
//       onRequest: (options, handler) {
//         // Called before the request is sent
//         print("Request: ${options.method} ${options.path}");
//         // You can modify the request here if needed
//         return handler.next(options); // continue with the request
//       },
//       onResponse: (response, handler) {
//         // Called when a response is received
//         print("Response: ${response.statusCode} ${response.data}");
//         return handler.next(response); // continue with the response
//       },
//       onError: (DioException e, handler) {
//         // Called when an error occurs
//         print("Error: ${e.message}");
//         return handler.next(e); // continue with the error
//       },
//     ));

//   Future<List<Recipe>> fetchRecipe() async {
//     try {
//       final response = await _dio.get('/recipes');

//       if (response.statusCode == 200) {
//         final recipeJsonModel = RecipeModel.fromJson(response.data);
//         return recipeJsonModel.recipes;
//       } else {
//         throw Exception("Failed with status code: ${response.statusCode}");
//       }
//     } on DioException catch (e) {
//       // handle different Dio errors nicely
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception("Connection Timeout");
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception("Receive Timeout");
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception("Server responded with: ${e.response?.statusCode}");
//       } else {
//         throw Exception("Unexpected error: ${e.message}");
//       }
//     } catch (e) {
//       throw Exception("Error while fetching data: $e");
//     }
//   } 
// }


// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:mero_app/data/models/recipe_detail_model.dart';
// import 'package:mero_app/data/models/recipe_model.dart';

// @lazySingleton  // ✅ Marks this class for DI - creates one instance when first needed
// class RecipeDatasource {
//   final Dio _dio;

//   // Constructor injection - injectable will provide Dio automatically
//   RecipeDatasource(this._dio);

//   Future<List<Recipe>> fetchRecipe() async {
//     try {
//       final response = await _dio.get('/recipes');

//       if (response.statusCode == 200) {
//         final recipeJsonModel = RecipeModel.fromJson(response.data);
//         return recipeJsonModel.recipes;
//       } else {
//         throw Exception("Failed with status code: ${response.statusCode}");
//       }
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception("Connection Timeout");
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception("Receive Timeout");
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception("Server responded with: ${e.response?.statusCode}");
//       } else {
//         throw Exception("Unexpected error: ${e.message}");
//       }
//     } catch (e) {
//       throw Exception("Error while fetching data: $e");
//     }
//   }


//   Future<RecipeDetailModel> fetchRecipeDetail(int id) async {
//     try {
//       final response = await _dio.get("/recipes/$id");

//       if(response.statusCode == 200){
        
//         // final Map<String, dynamic>jsonList = response.data;

//         // final recipeDetail = 
        
//         return RecipeDetailModel.fromJson(response.data);

//         // return recipeDetail;
//       } else {
//         throw Exception("There is response status code is: ${response.statusCode}");
//       }
//     }  on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception("Connection Timeout");
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception("Receive Timeout");
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception("Server responded with: ${e.response?.statusCode}");
//       } else {
//         throw Exception("Unexpected error: ${e.message}");
//       }
//     } catch (e) {
//       throw Exception("Error while fetching data: $e");
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mero_app/data/models/recipe_detail_model.dart';
import 'package:mero_app/data/models/recipe_model.dart';

@lazySingleton
class RecipeDatasource {
  final Dio _dio;

  RecipeDatasource(this._dio);

  Future<List<Recipe>> fetchRecipe() async {
    try {
      final response = await _dio.get('/recipes');

      if (response.statusCode == 200) {
        final recipeJsonModel = RecipeModel.fromJson(response.data);
        return recipeJsonModel.recipes;
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw _handleError(e);  
    }
  }

  Future<RecipeDetailModel> fetchRecipeDetail(int id) async {
    try {
      final response = await _dio.get("/recipes/$id");

      if (response.statusCode == 200) {
        return RecipeDetailModel.fromJson(response.data);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw _handleError(e);  
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception("Connection Timeout");
        case DioExceptionType.receiveTimeout:
          return Exception("Receive Timeout");
        case DioExceptionType.badResponse:
          return Exception("Server Error: ${error.response?.statusCode}");
        default:
          return Exception("Network Error: ${error.message}");
      }
    }
    return Exception("Error while fetching data: $error");
  }
}