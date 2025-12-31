part of 'recipe_bloc.dart';

// @immutable
// sealed class RecipeState {}

// final class RecipeInitial extends RecipeState {}

// final class RecipeLoading extends RecipeState {}

// final class RecipeLoaded extends RecipeState {
//   final List<RecipeEntity> recipe;

//   RecipeLoaded({required this.recipe});
// }

// final class RecipeError extends RecipeState {
//   final String errorMessage;

//   RecipeError({required this.errorMessage});
// }

enum FetchRecipeStatus { initial, loading, success, error }

class RecipeDataState extends Equatable {
  final FetchRecipeStatus status;
  final List<RecipeEntity> recipe;
  final RecipeDetailEntity? recipeDetail;
  final int productID;

  const RecipeDataState({
    this.status = FetchRecipeStatus.initial,
    this.recipe = const [],
    this.recipeDetail,
    this.productID =0,
  });

  RecipeDataState copyWith({
    List<RecipeEntity>? recipe,
    RecipeDetailEntity? recipeDetail,
    FetchRecipeStatus? status,
    int? productID,
  }) {
    return RecipeDataState(
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
      recipeDetail: recipeDetail ?? this.recipeDetail,
      productID: productID??this.productID,
    );
  }

  @override
  List<Object?> get props => [recipe, status, recipeDetail,productID];
}