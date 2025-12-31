import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_app/core/constants/app_color.dart';
import 'package:mero_app/presentation/bloc/recipe_bloc.dart';

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
      backgroundColor: getColorByTheme(context: context, colorClass: AppColors.backgroundColor),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Text("Recipe Details"),
      ),
      body: BlocBuilder<RecipeBloc, RecipeDataState>(
        builder: (context, state) {
          if (state.status == FetchRecipeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == FetchRecipeStatus.error) {
            return const Center(child: Text('Failed to load recipe details.'));
          } else if (state.status == FetchRecipeStatus.success) {
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
                  Text(
                    detailData.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Difficulty and Cuisine
                  Row(
                    children: [
                      Chip(label: Text("Difficulty: ${detailData.difficulty}")),
                      const SizedBox(width: 10),
                      Chip(label: Text("Cuisine: ${detailData.cuisine}")),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Ingredients
                  Text(
                    "Ingredients",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...detailData.ingredients
                      .map((ingredient) => Text("• $ingredient"))
                      .toList(),

                  const SizedBox(height: 16),

                  // Instructions
                  Text(
                    "Instructions",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...detailData.instructions
                      .asMap()
                      .entries
                      .map((entry) => Text("${entry.key + 1}. ${entry.value}"))
                      .toList(),

                  const SizedBox(height: 16),

                  // Calories, Servings, Rating
                  Text("Calories: ${detailData.caloriesPerServing} kcal"),
                  Text("Servings: ${detailData.servings}"),
                  Text(
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
