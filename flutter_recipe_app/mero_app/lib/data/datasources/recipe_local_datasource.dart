import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:drift/drift.dart' as drift;
import 'package:mero_app/core/database/app_database.dart';
import 'package:mero_app/core/database/daos/recipe_dao.dart';
import 'package:mero_app/data/models/recipe_model.dart' hide Recipe;
import 'package:mero_app/domain/entities/recipe_entity.dart';

@lazySingleton
class RecipeLocalDatasource {
  final RecipeDao _recipeDao;

  RecipeLocalDatasource(this._recipeDao);

  RecipesCompanion _entityToCompanion(RecipeEntity entity) {
    return RecipesCompanion(
      remoteId: drift.Value(entity.id),
      name: drift.Value(entity.name),
      cuisine: drift.Value(entity.cuisine),
      difficulty: entity.difficulty != null
          ? drift.Value(entity.difficulty.toString())
          : const drift.Value.absent(),
      image: drift.Value(entity.image),
      ingredients: drift.Value(jsonEncode(entity.ingredients)),
      instructions: drift.Value(jsonEncode(entity.instructions)),
      tags: drift.Value(jsonEncode(entity.tags)),
      mealType: drift.Value(jsonEncode(entity.mealType)),
      prepTimeMinutes: drift.Value(entity.prepTimeMinutes),
      cookTimeMinutes: drift.Value(entity.cookTimeMinutes),
      servings: drift.Value(entity.servings),
      caloriesPerServing: drift.Value(entity.caloriesPerServing),
      userId: drift.Value(entity.userId),
      reviewCount: drift.Value(entity.reviewCount),
      rating: drift.Value(entity.rating),
    );
  }

  RecipeEntity _recipeToEntity(Recipe recipe) {
    return RecipeEntity(
      id: recipe.remoteId ?? recipe.id,
      name: recipe.name,
      ingredients: List<String>.from(jsonDecode(recipe.ingredients)),
      instructions: List<String>.from(jsonDecode(recipe.instructions)),
      prepTimeMinutes: recipe.prepTimeMinutes,
      cookTimeMinutes: recipe.cookTimeMinutes,
      servings: recipe.servings,
      difficulty: Difficulty.EASY, // Parse from string if needed
      cuisine: recipe.cuisine ?? '',
      caloriesPerServing: recipe.caloriesPerServing,
      tags: recipe.tags != null
          ? List<String>.from(jsonDecode(recipe.tags!))
          : [],
      userId: recipe.userId,
      image: recipe.image ?? '',
      rating: recipe.rating,
      reviewCount: recipe.reviewCount,
      mealType: recipe.mealType != null
          ? List<String>.from(jsonDecode(recipe.mealType!))
          : [],
    );
    
  }

  Future<void> cacheRecipes(List<RecipeEntity> recipes) async {
    final companions = recipes.map(_entityToCompanion).toList();
    await _recipeDao.insertRecipes(companions);
  }

  Future<List<RecipeEntity>> getCachedRecipes() async {
    final recipes = await _recipeDao.getAllRecipes();
    return recipes.map(_recipeToEntity).toList();
  }


  
  // upsertRecipe
  Future<void> upsertRecipe(RecipeEntity entity) async {
    final companion = _entityToCompanion(entity);
    await _recipeDao.upsertRecipe(companion);
  }
}
