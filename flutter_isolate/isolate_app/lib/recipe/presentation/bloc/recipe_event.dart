part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class GetRecipeEvent extends RecipeEvent{}