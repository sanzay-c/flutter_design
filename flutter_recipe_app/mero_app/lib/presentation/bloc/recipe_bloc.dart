// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:mero_app/domain/entities/recipe_entity.dart';
// import 'package:mero_app/domain/usecases/recipe_usecase.dart';
// import 'package:meta/meta.dart';

// part 'recipe_event.dart';
// part 'recipe_state.dart';

// class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
//   final RecipeUsecase recipeUsecase;

//   RecipeBloc({required this.recipeUsecase}) : super(RecipeInitial()) {
//     on<FetchRecipeEvent>(_onFetchRecipeEvent);
//   }

//   FutureOr<void> _onFetchRecipeEvent(FetchRecipeEvent event, Emitter<RecipeState> emit) async {
//     try {
//       emit(RecipeLoading());
//       final recipe = await recipeUsecase();
//       emit(RecipeLoaded(recipe: recipe));
//     } catch (e) {
//       emit(RecipeError(errorMessage: "Error while fetching the data"));
//     }
//   }
// }

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mero_app/data/datasources/recipe_local_datasource.dart';
import 'package:mero_app/domain/entities/recipe_detail_entity.dart';
import 'package:mero_app/domain/entities/recipe_entity.dart';
import 'package:mero_app/domain/usecases/recipe_detail_usecase.dart';
import 'package:mero_app/domain/usecases/recipe_usecase.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

@injectable // ✅ Creates new instance each time (not singleton)
class RecipeBloc extends Bloc<RecipeEvent, RecipeDataState> {
  final RecipeUsecase recipeUsecase;
  final RecipeDetailUsecase recipeDetail;
  final RecipeLocalDatasource recipeLocalDatasource;

  RecipeBloc(this.recipeUsecase, this.recipeDetail, this.recipeLocalDatasource) : super(RecipeDataState()) {
    on<FetchRecipeEvent>(_onFetchRecipeEvent);
    on<UpdateProductIDEvent>(_onUpdateProductIDEvent);
    on<GetRecipeDetailEvent>(_onGetRecipeDetailEvent);

    on<SaveSingleRecipeToLocalEvent>(_onSaveSingleRecipeToLocalEvent);
  }

  FutureOr<void> _onFetchRecipeEvent(
    FetchRecipeEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FetchRecipeStatus.loading));
      final recipe = await recipeUsecase();
      emit(state.copyWith(recipe: recipe, status: FetchRecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FetchRecipeStatus.error));
    }
  }

  FutureOr<void> _onGetRecipeDetailEvent(
    GetRecipeDetailEvent event,
    Emitter<RecipeDataState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FetchRecipeStatus.loading));
      final recipes = await recipeDetail(state.productID);
      emit(
        state.copyWith(
          recipeDetail: recipes,
          status: FetchRecipeStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FetchRecipeStatus.error));
    }
  }

  FutureOr<void> _onUpdateProductIDEvent(
    UpdateProductIDEvent event,
    Emitter<RecipeDataState> emit,
  ) {
    emit(state.copyWith(productID: event.productID));
  }

  FutureOr<void> _onSaveSingleRecipeToLocalEvent(SaveSingleRecipeToLocalEvent event, Emitter<RecipeDataState> emit) async {
    try {
      // RecipeLocalDatasource मा update/insert (upsert) गर्ने method प्रयोग गर्नुहोस्।
      // मानिलिऔं कि तपाईंको Datasource मा 'upsertRecipe' वा 'cacheRecipe' भन्ने method छ।
      // यदि छैन भने, तपाईंको Local Datasource/Repo मा यो method बनाउनु पर्छ।
      
      // Local Datasource मा एउटा मात्र Recipe पठाउने:
      await recipeLocalDatasource.upsertRecipe(event.recipe); 

      // UI लाई कुनै State परिवर्तन गर्न आवश्यक छैन, वा सफलताको सन्देश मात्र दिन सकिन्छ।
      // यदि तपाईंले Local DB बाट डाटा watch गरिरहनु भएको छ भने, सूची आफै अपडेट हुन्छ।

      // हालको State मा कुनै परिवर्तन नगरेर सफलताको सन्देश मात्र दिनको लागि:
      // emit(state.copyWith(status: FetchRecipeStatus.success)); 
      
      // वा, यदि तपाईंले यो recipe save गरेपछि सूची अपडेट गर्न चाहनुहुन्छ भने, 
      // FetchRecipeEvent fire गर्न सकिन्छ।
      // add(FetchRecipeEvent()); 
      
    } catch (e) {
      // त्रुटि आएमा error state emit गर्नुहोस्
      emit(state.copyWith(status: FetchRecipeStatus.error)); 
    }
  }
}
