part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent extends Equatable{}

final class FetchRecipeEvent extends RecipeEvent{
  @override
  List<Object?> get props => [];
}

final class UpdateProductIDEvent extends RecipeEvent{
  final int productID;

  UpdateProductIDEvent({this.productID = 0});

  @override
  List<Object?> get props => [productID];
}

final class GetRecipeDetailEvent extends RecipeEvent {
  GetRecipeDetailEvent();

  @override
  List<Object?> get props => [];
}



final class SaveSingleRecipeToLocalEvent extends RecipeEvent {
  final RecipeEntity recipe;
  SaveSingleRecipeToLocalEvent(this.recipe);
  @override
  List<Object?> get props => [recipe];
}
