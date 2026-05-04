
import 'package:isolate_app/recipe/data/datasource/recipe_datasource.dart';
import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';
import 'package:isolate_app/recipe/domain/repositories/recipe_repo.dart';

class RecipeRepoImpl implements RecipeRepo {
  final RecipeDatasource recipeDatasource;

  RecipeRepoImpl({required this.recipeDatasource});

  @override
  Future<List<RecipeEntity>> getRecipe() async {
    final result = await recipeDatasource.getRecipe();
    return result.map((e) => e.toEntity()).toList();
  }
}