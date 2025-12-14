import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart';

@lazySingleton
class RecipeUsecase {
  final RecipeRepo recipeRepo;

  RecipeUsecase(this.recipeRepo);

  Future<List<RecipeEntity>> call() async {
    return await recipeRepo.getRecipes();
  }
}