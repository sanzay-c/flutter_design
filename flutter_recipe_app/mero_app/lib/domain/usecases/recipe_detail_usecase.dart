import 'package:injectable/injectable.dart';
import 'package:mero_app/domain/entities/recipe_detail_entity.dart';
import 'package:mero_app/domain/repositories/recipe_repo.dart';

@lazySingleton 
class RecipeDetailUsecase {
  final RecipeRepo recipeRepo;

  RecipeDetailUsecase(this.recipeRepo);

  Future<RecipeDetailEntity> call(int id) async {
    return await recipeRepo.getRecipeDetail(id);
  }
}