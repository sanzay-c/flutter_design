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
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';
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
      drawer: RecipeDrawer(),
      //  Drawer(
      //   backgroundColor: getColorByTheme(
      //     context: context,
      //     colorClass: AppColors.backgroundColor,
      //   ),
      //   child: SafeArea(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         ListTile(
      //           title: Content(text: "Dark Mode", fontSize: 20.sp),
      //           trailing: CupertinoSwitch(
      //             value: isDark,
      //             activeTrackColor: CupertinoColors.systemGreen,
      //             inactiveTrackColor: CupertinoColors.systemGrey4,
      //             onChanged: (value) {
      //               context.read<ThemeBloc>().add(ToggleThemeEvent());
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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

                  return Dismissible(
                    key: Key(recipe.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.w),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      // Show confirmation dialog
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Recipe"),
                            content: const Text(
                              "Are you sure you want to delete this recipe from local storage?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      // ✅ Delete from local DB
                      context.read<RecipeBloc>().add(
                        DeleteLocalRecipeEvent(recipe.id),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${recipe.name} deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // ✅ Restore recipe
                              context.read<RecipeBloc>().add(
                                UpdateLocalRecipeEvent(recipe),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        context.read<RecipeBloc>().add(
                          UpdateProductIdEvent(productID: recipe.id),
                        );
                        getIt<NavigationService>().pushNamed(
                          RouteName.recipeDetailsScreen,
                        );
                      },
                      onLongPress: () {
                        // ✅ Long press - edit
                        _showEditDialog(context, recipe);
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

// Create a function in RecipeScreen
void _showEditDialog(BuildContext context, RecipeEntity recipe) {
  final nameController = TextEditingController(text: recipe.name);
  final cuisineController = TextEditingController(text: recipe.cuisine);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Recipe'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Recipe Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: cuisineController,
            decoration: const InputDecoration(
              labelText: 'Cuisine',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // ✅ Update recipe
            final updatedRecipe = RecipeEntity(
              id: recipe.id,
              name: nameController.text,
              cuisine: cuisineController.text,
              ingredients: recipe.ingredients,
              instructions: recipe.instructions,
              prepTimeMinutes: recipe.prepTimeMinutes,
              cookTimeMinutes: recipe.cookTimeMinutes,
              servings: recipe.servings,
              difficulty: recipe.difficulty,
              caloriesPerServing: recipe.caloriesPerServing,
              tags: recipe.tags,
              userId: recipe.userId,
              image: recipe.image,
              rating: recipe.rating,
              reviewCount: recipe.reviewCount,
              mealType: recipe.mealType,
            );

            context.read<RecipeBloc>().add(
              UpdateLocalRecipeEvent(updatedRecipe),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recipe updated!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

class RecipeDrawer extends StatefulWidget {
  const RecipeDrawer({super.key});

  @override
  State<RecipeDrawer> createState() => _RecipeDrawerState();
}

class _RecipeDrawerState extends State<RecipeDrawer> {
  @override
  void initState() {
    super.initState();
    // Load local DB recipes when drawer opens
    // context.read<RecipeBloc>().add(LoadLocalRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Dark mode toggle
            ListTile(
              title: Text("Dark Mode", style: TextStyle(fontSize: 18.sp)),
              trailing: CupertinoSwitch(
                value: isDark,
                activeColor: Colors.green,
                onChanged: (value) {
                  // Toggle theme
                  // Assuming you have ThemeBloc setup
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ),
            ),

            const Divider(),

            // Local recipes list
            Expanded(
              child: BlocBuilder<RecipeBloc, RecipeDataState>(
                builder: (context, state) {
                  final List<RecipeEntity> localRecipes = state.recipe;

                  if (localRecipes.isEmpty) {
                    return const Center(child: Text('No saved recipes'));
                  }

                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.delete_forever),
                        title: const Text('Clear All Local Data'),
                        onTap: () {
                          context.read<RecipeBloc>().add(
                            ClearLocalCacheEvent(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All local recipes deleted!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      ),

                      const Divider(),

                      Expanded(
                        child: ListView.builder(
                          itemCount: localRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = localRecipes[index];

                            return Dismissible(
                              key: Key(recipe.id.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.w),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Recipe'),
                                    content: const Text(
                                      'Are you sure you want to delete this recipe?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onDismissed: (_) {
                                context.read<RecipeBloc>().add(
                                  DeleteLocalRecipeEvent(recipe.id),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${recipe.name} deleted'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        context.read<RecipeBloc>().add(
                                          UpdateLocalRecipeEvent(recipe),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.w),
                                  child: Image.network(
                                    recipe.image,
                                    width: 50.w,
                                    height: 50.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                                title: Text(recipe.name),
                                subtitle: Text(recipe.cuisine),
                                onTap: () {
                                  context.read<RecipeBloc>().add(
                                    UpdateProductIdEvent(productID: recipe.id),
                                  );
                                  getIt<NavigationService>().pushNamed(
                                    RouteName.recipeDetailsScreen,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
