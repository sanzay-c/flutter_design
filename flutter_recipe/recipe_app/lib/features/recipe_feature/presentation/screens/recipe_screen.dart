import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/bloc/theme_bloc.dart';
import 'package:recipe_app/common/appbar/recipe_appbar.dart';
import 'package:recipe_app/common/widgets/list_shimmer.dart';
import 'package:recipe_app/common/widgets/status_error.dart';
import 'package:recipe_app/core/constants/app_color.dart';
import 'package:recipe_app/core/di/injection.dart';
import 'package:recipe_app/core/enum/difficulty.dart';
import 'package:recipe_app/core/routing/navigation_services.dart';
import 'package:recipe_app/core/routing/route_name.dart';
import 'package:recipe_app/features/recipe_feature/presentation/bloc/recipe_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/common/widgets/content.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            getIt<NavigationService>().pushNamed(RouteName.addNewRecipeScreen),
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Content(text: "Dark Mode", fontSize: 20.sp),
                trailing: CupertinoSwitch(
                  value: isDark,
                  activeTrackColor: CupertinoColors.systemGreen,
                  inactiveTrackColor: CupertinoColors.systemGrey4,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: const RecipeAppBar(title: 'Recipes'),
      body: BlocBuilder<RecipeBloc, RecipeDataState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.loading) {
            return const ListShimmer();
          } else if (state.status == RecipeStatus.error) {
            return const StatusError(
              text: 'There is error while fetching the data.',
            );
          } else if (state.status == RecipeStatus.success ||
              state.status == RecipeStatus.recipeAdded) {
            
            final recipeData = state.recipe;

            if (recipeData.isEmpty) {
              return const Center(child: Content(text: 'No recipes found'));
            }

            return Padding(
              padding: EdgeInsets.all(8.0.w),
              child: ListView.builder(
                itemCount: recipeData.length,
                itemBuilder: (context, index) {
                  final recipe = recipeData[index];

                  // ✅ Highlight newly added recipe
                  final isNewRecipe = state.newRecipe?.id == recipe.id;

                  return GestureDetector(
                    onTap: () {
                      context.read<RecipeBloc>().add(
                        UpdateProductIdEvent(productID: recipe.id),
                      );
                      getIt<NavigationService>().pushNamed(
                        RouteName.recipeDetailsScreen,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getColorByTheme(
                            context: context,
                            colorClass: AppColors.backgroundColor,
                          ),
                          border:
                              isNewRecipe // higlight new recipe with the color
                              ? Border.all(color: Colors.green, width: 3.w)
                              : null,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        height: 100.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.w),
                              child: Image.network(
                                recipe.image,
                                height: 100.h,
                                width: 150.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 80.h,
                                    width: 80.w,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Content(text: recipe.name),
                                    4.verticalSpace,
                                    Content(
                                      text:
                                          difficultyValues.reverse[recipe
                                              .difficulty] ??
                                          'Unknown',
                                    ),
                                    4.verticalSpace,
                                    Content(text: recipe.cuisine),
                                    4.verticalSpace,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
