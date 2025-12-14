import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';

abstract class RecipeRepo {
  Future<List<RecipeEntity>> getRecipes();
  Future<RecipeDetailEntity> getRecipeDetail(int id);
   Future<RecipeEntity> addRecipe(AddRecipeRequestModel recipeRequest);
}