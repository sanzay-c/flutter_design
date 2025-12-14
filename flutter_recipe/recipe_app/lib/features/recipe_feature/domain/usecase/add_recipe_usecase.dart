import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart';

@lazySingleton
class AddRecipeUsecase {
  final RecipeRepo recipeRepo;

  AddRecipeUsecase(this.recipeRepo);

  Future<RecipeEntity> call(AddRecipeRequestModel recipeRequest) async {
    return await recipeRepo.addRecipe(recipeRequest);
  }
}