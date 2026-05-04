import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_app/network_module.dart';
import 'package:isolate_app/recipe/data/datasource/recipe_datasource.dart';
import 'package:isolate_app/recipe/data/repo_impl/recipe_repo_impl.dart';
import 'package:isolate_app/recipe/domain/usecases/recipe_usecase.dart';
import 'package:isolate_app/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:isolate_app/recipe/presentation/screens/recipe_screen.dart';

// Create a concrete class for NetworkModule if it's abstract
class NetworkModuleImpl extends NetworkModule {}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Use NetworkModule to get the Dio instance (Base URL is already there)
    final networkModule = NetworkModuleImpl();
    final dio = networkModule.dio();

    // 2. Setup dependencies using the dio instance from NetworkModule
    final recipeDatasource = RecipeDatasourceImpl(dio: dio);
    final recipeRepo = RecipeRepoImpl(recipeDatasource: recipeDatasource);
    final recipeUsecase = RecipeUsecase(recipeRepo: recipeRepo);

    return BlocProvider(
      create: (context) => RecipeBloc(recipeUsecase: recipeUsecase),
      child: MaterialApp(
        title: 'Flutter Isolate Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
        ),
        home: const RecipeScreen(),
      ),
    );
  }
}
