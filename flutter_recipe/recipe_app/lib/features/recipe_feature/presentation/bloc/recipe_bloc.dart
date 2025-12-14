import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/recipe_feature/domain/usecase/add_recipe_usecase.dart';
import 'package:recipe_app/features/recipe_feature/domain/usecase/recipe_detail_usecase.dart';
import 'package:recipe_app/features/recipe_feature/domain/usecase/recipe_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeDataState> {
  final RecipeUsecase recipeUsecase;
  final RecipeDetailUsecase recipeDetailUsecase;
  final AddRecipeUsecase addRecipeUsecase;
  RecipeBloc(this.recipeUsecase, this.recipeDetailUsecase, this.addRecipeUsecase) : super(const   RecipeDataState()) {
    on<FetchRecipeEvent>(_onFetchRecipeEvent);
    on<UpdateProductIdEvent>(_onUpdateProductIdEvent);
    on<GetRecipeDetailEvent>(_onGetRecipeDetailEvent);
    on<AddRecipeEvent>(_onAddRecipeEvent);
  }

  FutureOr<void> _onFetchRecipeEvent(FetchRecipeEvent event, Emitter<RecipeDataState> emit) async {
    try {
      emit(state.copyWith(status: RecipeStatus.loading));
      final recipe = await recipeUsecase();
      emit(state.copyWith(recipe: recipe, status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  FutureOr<void> _onUpdateProductIdEvent(UpdateProductIdEvent event, Emitter<RecipeDataState> emit) async {
    emit(state.copyWith(productID: event.productID));
  }

  FutureOr<void> _onGetRecipeDetailEvent(GetRecipeDetailEvent event, Emitter<RecipeDataState> emit) async {
    try {
      emit(state.copyWith(status: RecipeStatus.loading));
      final recipes = await recipeDetailUsecase(state.productID);
      emit(
        state.copyWith(
          recipeDetail: recipes,
          status: RecipeStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  // FutureOr<void> _onAddRecipeEvent(AddRecipeEvent event, Emitter<RecipeDataState> emit) async {
  //   try {
  //     emit(state.copyWith(status: RecipeStatus.loading));
  //     final newRecipe = await addRecipeUsecase(event.recipeRequest);

  //     final recipes = await recipeUsecase();
  //     emit(state.copyWith(recipe: recipes, status: RecipeStatus.success)); // fetching all the recipe before creating a new one

  //     emit(state.copyWith(newRecipe: newRecipe, status: RecipeStatus.success));
  //   } catch (e) {
  //     emit(state.copyWith(status: RecipeStatus.error));
  //   }
  // }

  FutureOr<void> _onAddRecipeEvent(
    AddRecipeEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
       emit(state.copyWith(status: RecipeStatus.loading));
      
      // Add new recipe
      final newRecipe = await addRecipeUsecase(event.recipeRequest);
      
      // Fetch updated list
      final recipes = await recipeUsecase();
      
      emit(
        state.copyWith(
          recipe: recipes,
          newRecipe: newRecipe,
          status: RecipeStatus.recipeAdded,  
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }
}
