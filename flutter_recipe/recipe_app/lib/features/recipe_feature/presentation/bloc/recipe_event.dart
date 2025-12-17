part of 'recipe_bloc.dart';


@immutable
sealed class RecipeEvent extends Equatable{}

final class FetchRecipeEvent extends RecipeEvent{
  @override
  List<Object?> get props => [];
}

final class UpdateProductIdEvent extends RecipeEvent{
  final int productID;

  UpdateProductIdEvent({this.productID = 0});
  
  @override
  List<Object?> get props => [productID];
}

final class GetRecipeDetailEvent extends RecipeEvent {
  GetRecipeDetailEvent();
  
  @override
  List<Object?> get props => [];
}

final class AddRecipeEvent extends RecipeEvent {
  final AddRecipeRequestModel recipeRequest;

  AddRecipeEvent(this.recipeRequest);

  @override
  List<Object?> get props => [recipeRequest];
}


// ✅ NEW: Local Database Events

// Save recipes to local DB
final class SaveRecipesToLocalEvent extends RecipeEvent {
  final List<RecipeEntity> recipes;
  SaveRecipesToLocalEvent(this.recipes);
  @override
  List<Object?> get props => [recipes];
}

// Load recipes from local DB
final class LoadLocalRecipesEvent extends RecipeEvent {
  @override
  List<Object?> get props => [];
}

// Delete recipe from local DB
final class DeleteLocalRecipeEvent extends RecipeEvent {
  final int recipeId;
  DeleteLocalRecipeEvent(this.recipeId);
  @override
  List<Object?> get props => [recipeId];
}

// Update local recipe
final class UpdateLocalRecipeEvent extends RecipeEvent {
  final RecipeEntity recipe;
  UpdateLocalRecipeEvent(this.recipe);
  @override
  List<Object?> get props => [recipe];
}

// Clear all local data
final class ClearLocalCacheEvent extends RecipeEvent {
  @override
  List<Object?> get props => [];
}

// Search local recipes
final class SearchLocalRecipesEvent extends RecipeEvent {
  final String query;
  SearchLocalRecipesEvent(this.query);
  @override
  List<Object?> get props => [query];
}