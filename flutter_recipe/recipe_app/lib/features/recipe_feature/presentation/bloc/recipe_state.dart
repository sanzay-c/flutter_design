part of 'recipe_bloc.dart';

enum RecipeStatus {
  initial,
  loading,
  success,
  error,
  recipeAdded,  
}

class RecipeDataState extends Equatable {
  final RecipeStatus status;
  final List<RecipeEntity> recipe;
  final RecipeDetailEntity? recipeDetail;
  final RecipeEntity? newRecipe;
  final int productID;

  const RecipeDataState({
    this.status = RecipeStatus.initial,
    this.recipe = const [],
    this.recipeDetail,
    this.newRecipe,
    this.productID = 0,
  });

  RecipeDataState copyWith({
    List<RecipeEntity>? recipe,
    RecipeDetailEntity? recipeDetail,
    RecipeStatus? status,
    RecipeEntity? newRecipe,
    int? productID,
  }) {
    return RecipeDataState(
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
      recipeDetail: recipeDetail ?? this.recipeDetail,
      productID: productID ?? this.productID,
      newRecipe: newRecipe ?? this.newRecipe,
    );
  }

  @override
  List<Object?> get props => [recipe, status, recipeDetail, newRecipe, productID];
}