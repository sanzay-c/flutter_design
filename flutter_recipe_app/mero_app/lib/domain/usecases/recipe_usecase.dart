// import 'package:mero_app/domain/entities/recipe_entity.dart';
// import 'package:mero_app/domain/repositories/recipe_repo.dart';

// class RecipeUsecase {
//   final RecipeRepo recipeRepo;

//   RecipeUsecase({required this.recipeRepo});

//   Future<List<RecipeEntity>> call() async {
//     return await recipeRepo.getRecipe();
//   }
// }



import 'package:injectable/injectable.dart';
import 'package:mero_app/domain/entities/recipe_entity.dart';
import 'package:mero_app/domain/repositories/recipe_repo.dart';

@lazySingleton  // ✅ Single instance for use case
class RecipeUsecase {
  final RecipeRepo recipeRepo;

  RecipeUsecase(this.recipeRepo);  // Repository injected automatically

  Future<List<RecipeEntity>> call() async {
    return await recipeRepo.getRecipe();
  }
}