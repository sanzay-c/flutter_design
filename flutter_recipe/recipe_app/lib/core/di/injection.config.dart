// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:recipe_app/common/bloc/theme_bloc.dart' as _i824;
import 'package:recipe_app/core/database/app_database.dart' as _i776;
import 'package:recipe_app/core/database/daos/recipe_dao.dart' as _i877;
import 'package:recipe_app/core/di/network_module.dart' as _i53;
import 'package:recipe_app/core/routing/navigation_services.dart' as _i883;
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_datasource.dart'
    as _i27;
import 'package:recipe_app/features/recipe_feature/data/datasource/recipe_local_datasource.dart'
    as _i73;
import 'package:recipe_app/features/recipe_feature/data/repo_impl/recipe_repo_impl.dart'
    as _i984;
import 'package:recipe_app/features/recipe_feature/domain/repo/recipe_repo.dart'
    as _i914;
import 'package:recipe_app/features/recipe_feature/domain/usecase/add_recipe_usecase.dart'
    as _i619;
import 'package:recipe_app/features/recipe_feature/domain/usecase/recipe_detail_usecase.dart'
    as _i84;
import 'package:recipe_app/features/recipe_feature/domain/usecase/recipe_usecase.dart'
    as _i519;
import 'package:recipe_app/features/recipe_feature/presentation/bloc/recipe_bloc.dart'
    as _i989;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i824.ThemeBloc>(() => _i824.ThemeBloc());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i776.AppDatabase>(() => networkModule.database);
    gh.lazySingleton<_i877.RecipeDao>(() => networkModule.recipeDao);
    gh.lazySingleton<_i883.NavigationService>(() => _i883.NavigationService());
    gh.lazySingleton<_i73.RecipeLocalDatasource>(
      () => _i73.RecipeLocalDatasource(gh<_i877.RecipeDao>()),
    );
    gh.lazySingleton<_i27.RecipeDatasource>(
      () => _i27.RecipeDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i914.RecipeRepo>(
      () => _i984.RecipeRepoImpl(
        gh<_i27.RecipeDatasource>(),
        gh<_i73.RecipeLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i619.AddRecipeUsecase>(
      () => _i619.AddRecipeUsecase(gh<_i914.RecipeRepo>()),
    );
    gh.lazySingleton<_i84.RecipeDetailUsecase>(
      () => _i84.RecipeDetailUsecase(gh<_i914.RecipeRepo>()),
    );
    gh.lazySingleton<_i519.RecipeUsecase>(
      () => _i519.RecipeUsecase(gh<_i914.RecipeRepo>()),
    );
    gh.factory<_i989.RecipeBloc>(
      () => _i989.RecipeBloc(
        gh<_i519.RecipeUsecase>(),
        gh<_i84.RecipeDetailUsecase>(),
        gh<_i619.AddRecipeUsecase>(),
        gh<_i73.RecipeLocalDatasource>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i53.NetworkModule {}
