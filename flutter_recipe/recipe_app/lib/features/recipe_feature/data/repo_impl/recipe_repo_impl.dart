import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_datasource.dart';
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_local_datasource.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart';

@LazySingleton(as: RecipeRepo)
class RecipeRepoImpl implements RecipeRepo {
  final RecipeDatasource datasource;
  final RecipeLocalDatasource localDatasource;

  RecipeRepoImpl(this.datasource, this.localDatasource);

  // @override
  // Future<List<RecipeEntity>> getRecipes() async {
  //   final model = await datasource.fetchRecipes();
  //   return model.map((json) => json.toEntity()).toList();
  // }

  @override
  Future<List<RecipeEntity>> getRecipes() async {
    try {
      // Try to fetch from API
      final remoteRecipes = await datasource.fetchRecipes();
      final entities = remoteRecipes.map((r) => r.toEntity()).toList();
      
      // Cache in local DB
      await localDatasource.cacheRecipes(entities);
      
      return entities;
    } catch (e) {
      // If API fails, return cached data
      log('⚠️ API failed, using cached data: $e');
      return await localDatasource.getCachedRecipes();
    }
  }

  @override
  Future<RecipeDetailEntity> getRecipeDetail(int id) async {
    final model = await datasource.fetchRecipeDetail(id);
    return model.toEntity();
  }

  @override
  Future<RecipeEntity> addRecipe(AddRecipeRequestModel recipeRequest) async {
    final model = await datasource.addRecipe(recipeRequest);
    return model.toEntity();
  }

  // Watch recipes (real-time from DB)
  Stream<List<RecipeEntity>> watchRecipes() {
    return localDatasource.watchRecipes();
  }
}