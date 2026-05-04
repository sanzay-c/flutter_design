
import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';
import 'package:isolate_app/recipe/domain/repositories/recipe_repo.dart';

class RecipeUsecase {
  final RecipeRepo recipeRepo;

  RecipeUsecase({required this.recipeRepo});

  Future<List<RecipeEntity>> call() async {
    return await recipeRepo.getRecipe();
  }
}
