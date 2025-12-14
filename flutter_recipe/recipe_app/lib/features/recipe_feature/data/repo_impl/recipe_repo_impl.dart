import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_datasource.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart';

@LazySingleton(as: RecipeRepo)
class RecipeRepoImpl implements RecipeRepo {
  final RecipeDatasource datasource;

  RecipeRepoImpl(this.datasource);

  @override
  Future<List<RecipeEntity>> getRecipes() async {
    final model = await datasource.fetchRecipes();
    return model.map((json) => json.toEntity()).toList();
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
}