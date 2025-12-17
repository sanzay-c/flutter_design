import 'package:drift/drift.dart';
import 'package:recipe_app/core/database/app_database.dart';

import 'package:recipe_app/core/database/tables/recipe_table.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes]) // used recipe table
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(AppDatabase db) : super(db);

  // Get all recipes (SELECT * FROM recipes)
  Future<List<Recipe>> getAllRecipes() {
    return select(recipes).get();
  }

  // Get recipe by ID (SELECT * FROM recipes WHERE id = ?)
  Future<Recipe?> getRecipeById(int id) {
    return (select(recipes)..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  // Get recipe by remote ID (from API) 
  Future<Recipe?> getRecipeByRemoteId(int remoteId) {
    return (select(recipes)..where((r) => r.remoteId.equals(remoteId)))
        .getSingleOrNull();
  }

  // Insert or update recipe (INSERT OR REPLACE)
  Future<int> upsertRecipe(RecipesCompanion recipe) {
    return into(recipes).insertOnConflictUpdate(recipe);
  }

  // Insert multiple recipes (bulk)
  Future<void> insertRecipes(List<RecipesCompanion> recipeList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(recipes, recipeList);
    });
  }

  // Update recipe
  Future<bool> updateRecipe(Recipe recipe) {
    return update(recipes).replace(recipe);
  }

  // Delete recipe
  Future<int> deleteRecipe(int id) {
    return (delete(recipes)..where((r) => r.id.equals(id))).go();
  }

  // Delete all recipes
  Future<int> deleteAllRecipes() {
    return delete(recipes).go();
  }

  // search recipes by name
  Future<List<Recipe>> searchRecipes(String query) {
    return (select(recipes)
          ..where((r) => r.name.contains(query)))
        .get();
  }

  // Filter by cuisine
  Future<List<Recipe>> getRecipesByCuisine(String cuisine) {
    return (select(recipes)..where((r) => r.cuisine.equals(cuisine))).get();
  }

  // Filter by difficulty
  Future<List<Recipe>> getRecipesByDifficulty(String difficulty) {
    return (select(recipes)..where((r) => r.difficulty.equals(difficulty))).get();
  }

  // Get recent recipes (last 10)
  Future<List<Recipe>> getRecentRecipes({int limit = 10}) {
    return (select(recipes)
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)])
          ..limit(limit))
        .get();
  }

  // Watch all recipes (for real-time updates)
  Stream<List<Recipe>> watchAllRecipes() {
    return select(recipes).watch();
  }

  // Watch single recipe
  Stream<Recipe?> watchRecipe(int id) {
    return (select(recipes)..where((r) => r.id.equals(id))).watchSingleOrNull();
  }
}