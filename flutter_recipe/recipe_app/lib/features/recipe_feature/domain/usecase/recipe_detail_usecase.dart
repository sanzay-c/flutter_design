import 'package:injectable/injectable.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart';

@lazySingleton
class RecipeDetailUsecase {
  final RecipeRepo recipeRepo;

  RecipeDetailUsecase(this.recipeRepo);
  
  Future<RecipeDetailEntity> call(int id) async {
    return await recipeRepo.getRecipeDetail(id);
  }
}