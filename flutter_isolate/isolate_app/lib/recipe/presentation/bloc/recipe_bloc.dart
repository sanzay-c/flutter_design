import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';
import 'package:isolate_app/recipe/domain/usecases/recipe_usecase.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeUsecase recipeUsecase;
  RecipeBloc({required this.recipeUsecase}) : super(RecipeState()) {
    on<GetRecipeEvent>(_onGetRecipeEvent);
  }

  FutureOr<void> _onGetRecipeEvent(GetRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      emit(state.copyWith(status: RecipeStatus.loading));
      final recipe = await recipeUsecase();
      emit(state.copyWith(status: RecipeStatus.success, recipes: recipe));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error, errorMessage: e.toString()));
    }
  }
}
