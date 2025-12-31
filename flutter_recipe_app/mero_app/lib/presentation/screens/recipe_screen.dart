import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_app/config/env_config.dart';
import 'package:mero_app/core/constants/app_color.dart';
import 'package:mero_app/core/di/injection.dart';
import 'package:mero_app/core/extensions/spacing_extensions.dart';
import 'package:mero_app/core/global_data/global_theme/bloc/theme_bloc.dart';
import 'package:mero_app/core/routing/navigation_service.dart';
import 'package:mero_app/core/routing/route_name.dart';
import 'package:mero_app/core/theme/responsive_text.dart';
import 'package:mero_app/core/utils/responsive/size.dart';
import 'package:mero_app/domain/entities/recipe_entity.dart';
import 'package:mero_app/presentation/bloc/recipe_bloc.dart';
// import 'package:mero_app/presentation/screens/recipe_detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the recipes when the screen loads
    context.read<RecipeBloc>().add(FetchRecipeEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),

      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                secondary: const Icon(Icons.dark_mode),
                value: isDark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ),
              const Divider(),
              Column(
                children: [
                  // Environment Info Section (Fixed Height)
                  Container(
                    padding: EdgeInsets.all(S.padding),
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Environment: ${EnvConfig.environment.name}'),
                        Text('API URL: ${EnvConfig.apiBaseUrl}'),
                        Text('Debug Mode: ${EnvConfig.debugMode}'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Recipes'),
      ),

      body: Column(
        children: [
          // Environment Info Section (Fixed Height)
          // Container(
          //   padding: EdgeInsets.all(S.padding),
          //   color: Colors.grey[100],
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('Environment: ${EnvConfig.environment.name}'),
          //       Text('API URL: ${EnvConfig.apiBaseUrl}'),
          //       Text('Debug Mode: ${EnvConfig.debugMode}'),
          //     ],
          //   ),
          // ),

          // Recipe List (Expandable)
          Expanded(
            child: BlocBuilder<RecipeBloc, RecipeDataState>(
              builder: (context, state) {
                if (state.status == FetchRecipeStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == FetchRecipeStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "There is Error while fetching the data",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  );
                } else if (state.status == FetchRecipeStatus.success) {
                  final data = state.recipe;

                  if (data.isEmpty) {
                    return const Center(child: Text('No recipes found'));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: S.padding,
                      vertical: S.padding,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final recipe = data[index];

                      return GestureDetector(
                        onTap: () {
                          context.read<RecipeBloc>().add(
                            UpdateProductIDEvent(productID: recipe.id),
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => const RecipeDetailsScreen(),
                          //   ),
                          // );
                          getIt<NavigationService>().pushNamed(
                            RouteName.recipeDetailsScreen,
                          );
                        },
                        onLongPress: () {
                          // BLoC मा event पठाउने
                          context.read<RecipeBloc>().add(
                            SaveSingleRecipeToLocalEvent(
                              recipe,
                            ), // हालको Recipe Entity पठाउने
                          );

                          // सफलताको सन्देश देखाउने
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                '${recipe.name} saved to local storage!',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: S.padding),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                S.borderRadius,
                              ),
                              border: Border.all(
                                color: const Color.fromARGB(190, 16, 50, 151),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(S.borderRadius),
                                  ),
                                  child: Image.network(
                                    recipe.image,
                                    height: S.imageHeight,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: S.imageHeight,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 48,
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        height: S.imageHeight,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                8.vSpace,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Text(
                                    recipe.name,
                                    style: ResponsiveTextStyle.title,
                                  ),
                                ),
                                4.vSpace,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
