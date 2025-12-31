import 'package:mero_app/domain/entities/recipe_detail_entity.dart';
import 'package:mero_app/domain/entities/recipe_entity.dart';

abstract class RecipeRepo {
  Future<List<RecipeEntity>> getRecipe();
  Future<RecipeDetailEntity> getRecipeDetail(int id);
}