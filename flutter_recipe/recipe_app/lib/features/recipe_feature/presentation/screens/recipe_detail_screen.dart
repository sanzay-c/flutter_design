import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/appbar/recipe_appbar.dart';
import 'package:recipe_app/common/widgets/content.dart';
import 'package:recipe_app/common/widgets/detail_shimmer.dart';
import 'package:recipe_app/core/constants/app_color.dart';
import 'package:recipe_app/features/recipe_feature/presentation/bloc/recipe_bloc.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(GetRecipeDetailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: RecipeAppBar(title: "Recipe Details",),
      body: BlocBuilder<RecipeBloc, RecipeDataState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.loading) {
            return DetailShimmer();
          } else if (state.status == RecipeStatus.error) {
            return const Center(child: Text('Failed to load recipe details.'));
          } else if (state.status == RecipeStatus.success) {
            final detailData = state.recipeDetail;

            if (detailData == null) {
              return const Center(child: Text('No details available.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      detailData.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Content(text: detailData.name, fontSize: 24.sp),

                  8.verticalSpace,

                  // Difficulty and Cuisine
                  Row(
                    children: [
                      Chip(
                        label: Text("Difficulty: ${detailData.difficulty}"),
                        backgroundColor: getColorByTheme(
                          context: context,
                          colorClass: AppColors.backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        label: Text("Cuisine: ${detailData.cuisine}"),
                        backgroundColor: getColorByTheme(
                          context: context,
                          colorClass: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,

                  Content(text: "Ingridients"),

                  8.verticalSpace,
                  ...detailData.ingredients
                      .map((ingredient) => Text("• $ingredient"))
                      .toList(),

                  16.verticalSpace,

                  // Instructions
                  Content(text: "Instructions"),

                  8.verticalSpace,
                  ...detailData.instructions
                      .asMap()
                      .entries
                      .map((entry) => Text("${entry.key + 1}. ${entry.value}"))
                      .toList(),

                  16.verticalSpace,

                  // Calories, Servings, Rating
                  Content(
                    text: "Calories: ${detailData.caloriesPerServing} kcal",
                  ),
                  Content(text: "Servings: ${detailData.servings}"),
                  Content(
                    text:
                        "Rating: ${detailData.rating} ⭐ (${detailData.reviewCount} reviews)",
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
