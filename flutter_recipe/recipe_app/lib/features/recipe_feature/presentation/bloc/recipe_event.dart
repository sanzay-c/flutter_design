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