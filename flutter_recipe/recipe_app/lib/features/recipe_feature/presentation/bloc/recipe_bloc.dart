import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_local_datasource.dart';
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
  final RecipeLocalDatasource localDatasource;  // ✅ Add this

  RecipeBloc(this.recipeUsecase, this.recipeDetailUsecase, this.addRecipeUsecase, this.localDatasource) : super(const   RecipeDataState()) {
    on<FetchRecipeEvent>(_onFetchRecipeEvent);
    on<UpdateProductIdEvent>(_onUpdateProductIdEvent);
    on<GetRecipeDetailEvent>(_onGetRecipeDetailEvent);
    on<AddRecipeEvent>(_onAddRecipeEvent);



     // ✅ NEW: Local DB handlers
    on<SaveRecipesToLocalEvent>(_onSaveRecipesToLocal);
    on<LoadLocalRecipesEvent>(_onLoadLocalRecipes);
    on<DeleteLocalRecipeEvent>(_onDeleteLocalRecipe);
    on<UpdateLocalRecipeEvent>(_onUpdateLocalRecipe);
    on<ClearLocalCacheEvent>(_onClearLocalCache);
    on<SearchLocalRecipesEvent>(_onSearchLocalRecipes);
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



  // ✅ NEW: Save recipes to local DB
  FutureOr<void> _onSaveRecipesToLocal(
    SaveRecipesToLocalEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      await localDatasource.cacheRecipes(event.recipes);
      emit(state.copyWith(recipe: event.recipes, status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  // ✅ NEW: Load from local DB
  FutureOr<void> _onLoadLocalRecipes(
    LoadLocalRecipesEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RecipeStatus.loading));
      final recipes = await localDatasource.getCachedRecipes();
      emit(state.copyWith(recipe: recipes, status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  // ✅ NEW: Delete recipe from local DB
  // FutureOr<void> _onDeleteLocalRecipe(
  //   DeleteLocalRecipeEvent event,
  //   Emitter<RecipeDataState> emit,
  // ) async {
  //   try {
  //     // Delete from local DB (you'll need to add this method to datasource)
  //     // await localDatasource.deleteRecipe(event.recipeId);
      
  //     // Refresh the list
  //     final recipes = await localDatasource.getCachedRecipes();
  //     emit(state.copyWith(recipe: recipes, status: RecipeStatus.success));
  //   } catch (e) {
  //     emit(state.copyWith(status: RecipeStatus.error));
  //   }
  // }

  FutureOr<void> _onDeleteLocalRecipe(
  DeleteLocalRecipeEvent event,
  Emitter<RecipeDataState> emit,
) async {
  try {
    // 1️⃣ Remove immediately from current state
    final updatedRecipes = List<RecipeEntity>.from(state.recipe)
      ..removeWhere((recipe) => recipe.id == event.recipeId);

    emit(
      state.copyWith(
        recipe: updatedRecipes,
        status: RecipeStatus.success,
      ),
    );

    // 2️⃣ Then delete from local DB (async, no UI impact)
    await localDatasource.getCachedRecipe(event.recipeId);

  } catch (e) {
    emit(state.copyWith(status: RecipeStatus.error));
  }
}


  // ✅ NEW: Update recipe in local DB
  FutureOr<void> _onUpdateLocalRecipe(
    UpdateLocalRecipeEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      // Update in local DB
      await localDatasource.cacheRecipes([event.recipe]);
      
      // Refresh the list
      final recipes = await localDatasource.getCachedRecipes();
      emit(state.copyWith(recipe: recipes, status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  // ✅ NEW: Clear local cache
  FutureOr<void> _onClearLocalCache(
    ClearLocalCacheEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      await localDatasource.clearCache();
      emit(state.copyWith(recipe: [], status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }

  // ✅ NEW: Search local recipes
  FutureOr<void> _onSearchLocalRecipes(
    SearchLocalRecipesEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RecipeStatus.loading));
      final recipes = await localDatasource.searchRecipes(event.query);
      emit(state.copyWith(recipe: recipes, status: RecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error));
    }
  }
}
