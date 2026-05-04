import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';

abstract class RecipeRepo {
  Future<List<RecipeEntity>> getRecipe();
}