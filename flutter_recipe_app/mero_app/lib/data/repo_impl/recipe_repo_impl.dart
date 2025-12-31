// import 'package:mero_app/data/datasources/data_source.dart';
// import 'package:mero_app/domain/entities/recipe_entity.dart';
// import 'package:mero_app/domain/repositories/recipe_repo.dart';

// class RecipeRepoImpl implements RecipeRepo {
//   final RecipeDatasource datasource;

//   RecipeRepoImpl({
//     required this.datasource,
//   });

//   @override
//   Future<List<RecipeEntity>> getRecipe() async {
//     final model = await datasource.fetchRecipe();
//     return model.map((json) => json.toEntity()).toList();
//   }
// }




import 'package:injectable/injectable.dart';
import 'package:mero_app/data/datasources/data_source.dart';
import 'package:mero_app/data/datasources/recipe_local_datasource.dart';
import 'package:mero_app/domain/entities/recipe_detail_entity.dart';
import 'package:mero_app/domain/entities/recipe_entity.dart';
import 'package:mero_app/domain/repositories/recipe_repo.dart';

@LazySingleton(as: RecipeRepo)  // ✅ Register as interface implementation
class RecipeRepoImpl implements RecipeRepo {
  final RecipeDatasource datasource;
  RecipeLocalDatasource localDatasource;

  RecipeRepoImpl(this.datasource, this.localDatasource);  // Datasource injected automatically

  @override
  Future<List<RecipeEntity>> getRecipe() async {
    final remoteRecipe = await datasource.fetchRecipe();
    final entities = remoteRecipe.map((json) => json.toEntity()).toList();

    await localDatasource.cacheRecipes(entities);

    return entities;
  }

  // @override
  // Future<List<RecipeEntity>> getRecipe() async {
  //   final model = await datasource.fetchRecipe();
  //   return model.map((json) => json.toEntity()).toList();
  // }

  @override
  Future<RecipeDetailEntity> getRecipeDetail(int id) async {
    final model = await datasource.fetchRecipeDetail(id);
    return model.toEntity();
  }
} 