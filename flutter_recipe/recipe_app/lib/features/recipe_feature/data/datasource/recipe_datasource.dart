import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/data/model/recipe_detail_model.dart';
import 'package:recipe_app/features/recipe_feature/data/model/recipe_model.dart';

@lazySingleton
class RecipeDatasource {
  final Dio _dio;

  RecipeDatasource(this._dio);

  Future<List<Recipe>> fetchRecipes() async {
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
      final response = await _dio.get('/recipes/$id');
      
      if (response.statusCode == 200) {
        return RecipeDetailModel.fromJson(response.data);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw _handleError(e);
    }
  }
  
 // lib/data/datasources/recipe_datasource.dart

Future<Recipe> addRecipe(AddRecipeRequestModel recipeRequest) async {
  try {
    final response = await _dio.post(
      '/recipes/add',
      data: recipeRequest.toJson(),
    );

    // ✅ Print full response to debug
    print('✅ Status Code: ${response.statusCode}');
    print('✅ Response Data: ${response.data}');
    print('✅ Response Type: ${response.data.runtimeType}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Try to parse
      try {
        return Recipe.fromJson(response.data);
      } catch (parseError) {
        print('❌ Parse Error: $parseError');
        print('❌ Response structure: ${response.data}');
        rethrow;
      }
    } else {
      throw Exception("Failed with status code: ${response.statusCode}");
    }
  } catch (e) {
    print('❌ Full Error: $e');
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
