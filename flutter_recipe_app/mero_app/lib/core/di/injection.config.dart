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
import 'package:mero_app/core/database/app_database.dart' as _i100;
import 'package:mero_app/core/database/daos/recipe_dao.dart' as _i1031;
import 'package:mero_app/core/di/network_module.dart' as _i615;
import 'package:mero_app/core/global_data/global_theme/bloc/theme_bloc.dart'
    as _i652;
import 'package:mero_app/core/routing/navigation_service.dart' as _i848;
import 'package:mero_app/data/datasources/data_source.dart' as _i211;
import 'package:mero_app/data/datasources/recipe_local_datasource.dart'
    as _i169;
import 'package:mero_app/data/repo_impl/recipe_repo_impl.dart' as _i740;
import 'package:mero_app/domain/repositories/recipe_repo.dart' as _i1043;
import 'package:mero_app/domain/usecases/recipe_detail_usecase.dart' as _i683;
import 'package:mero_app/domain/usecases/recipe_usecase.dart' as _i264;
import 'package:mero_app/presentation/bloc/recipe_bloc.dart' as _i271;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i652.ThemeBloc>(() => _i652.ThemeBloc());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i100.AppDatabase>(() => networkModule.database);
    gh.lazySingleton<_i1031.RecipeDao>(() => networkModule.recipeDao);
    gh.lazySingleton<_i848.NavigationService>(() => _i848.NavigationService());
    gh.lazySingleton<_i211.RecipeDatasource>(
      () => _i211.RecipeDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i169.RecipeLocalDatasource>(
      () => _i169.RecipeLocalDatasource(gh<_i1031.RecipeDao>()),
    );
    gh.lazySingleton<_i1043.RecipeRepo>(
      () => _i740.RecipeRepoImpl(
        gh<_i211.RecipeDatasource>(),
        gh<_i169.RecipeLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i683.RecipeDetailUsecase>(
      () => _i683.RecipeDetailUsecase(gh<_i1043.RecipeRepo>()),
    );
    gh.lazySingleton<_i264.RecipeUsecase>(
      () => _i264.RecipeUsecase(gh<_i1043.RecipeRepo>()),
    );
    gh.factory<_i271.RecipeBloc>(
      () => _i271.RecipeBloc(
        gh<_i264.RecipeUsecase>(),
        gh<_i683.RecipeDetailUsecase>(),
        gh<_i169.RecipeLocalDatasource>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i615.NetworkModule {}
