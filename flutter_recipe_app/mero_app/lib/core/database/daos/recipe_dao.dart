import 'package:drift/drift.dart';
import 'package:mero_app/core/database/app_database.dart';
import 'package:mero_app/core/database/table/recipe_table.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(AppDatabase db) : super(db);

  Future<List<Recipe>> getAllRecipes() {
    return select(recipes).get();
  }

  Future<Recipe?> getRecipeById(int id) {
    return (select(recipes)..where((r) => r.id.equals(id))).getSingleOrNull();
  }


  Future<void> insertRecipes(List<RecipesCompanion> recipeList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(recipes, recipeList);
    });
  }

    // Insert or update recipe (INSERT OR REPLACE)
  Future<int> upsertRecipe(RecipesCompanion recipe) {
    return into(recipes).insertOnConflictUpdate(recipe);
  }
}
