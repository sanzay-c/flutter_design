import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:isolate_app/recipe/data/models/recipe_model.dart';
// import 'package:flutter/foundation.dart'; // For compute

abstract class RecipeDatasource {
  Future<List<Recipe>> getRecipe();
}

class RecipeDatasourceImpl implements RecipeDatasource {
  final Dio dio;

  RecipeDatasourceImpl({required this.dio});


  @override
  Future<List<Recipe>> getRecipe() async {
    try {
      final response = await dio.get('/recipes/');
      if (response.statusCode == 200) {
        // Tapai le trial ko lagi jun use gare pani hunchha:
        
        // 1. Traditional Flutter way (compute)
        // return await compute(_parseRecipes, response.data);

        // 2. Modern Dart way (Isolate.run) - Simple & Recommended
        return await getRecipeWithIsolateRun(response.data);

        // 3. Manual control way (Isolate.spawn) - Detailed communication
        // return await getRecipeWithIsolateSpawn(response.data);
      }
      throw Exception("Unexpected status code: ${response.statusCode}");
    } on DioException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  /// METHOD 1: Using Isolate.run
  /// Simple, handles port management automatically.
  Future<List<Recipe>> getRecipeWithIsolateRun(dynamic data) async {
    return await Isolate.run(() => _parseRecipes(data));
  }

  /// METHOD 2: Using Isolate.spawn
  /// More control, shows how ports and messages work.
  Future<List<Recipe>> getRecipeWithIsolateSpawn(dynamic data) async {
    final receivePort = ReceivePort();
    
    // Spawn garne (data ra port Dubai pathauna Map use gareko)
    await Isolate.spawn(
      _parseWorker, 
      {'port': receivePort.sendPort, 'data': data},
    );

    final result = await receivePort.first;
    receivePort.close();

    if (result is List<Recipe>) {
      return result;
    } else {
      throw Exception("Isolate.spawn failed: $result");
    }
  }

  /// Worker function for Isolate.spawn (Must be static)
  static void _parseWorker(Map<String, dynamic> message) {
    final SendPort sendPort = message['port'];
    final dynamic data = message['data'];

    try {
      final recipes = _parseRecipes(data);
      sendPort.send(recipes);
    } catch (e) {
      sendPort.send(e.toString());
    }
  }

  /// Shared parsing logic
  static List<Recipe> _parseRecipes(dynamic data) {
    final List<dynamic> recipeList = data['recipes'] as List<dynamic>;
    return recipeList.map((json) => Recipe.fromJson(json as Map<String, dynamic>)).toList();
  }
}
