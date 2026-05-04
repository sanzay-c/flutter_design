// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_bloc.dart';

enum RecipeStatus { initila, loading, success, error }

class RecipeState {
  RecipeStatus? status;
  final String? errorMessage;
  List<RecipeEntity>? recipes;

  RecipeState({this.status, this.recipes, this.errorMessage});

  RecipeState copyWith({
    RecipeStatus? status,
    List<RecipeEntity>? recipes,
    String? errorMessage,
  }) {
    return RecipeState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
