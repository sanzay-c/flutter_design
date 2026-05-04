import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';
import 'package:isolate_app/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:isolate_app/recipe/presentation/screens/recipe_details_screen.dart';
import 'package:lottie/lottie.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch recipes when the screen loads
    context.read<RecipeBloc>().add(GetRecipeEvent());
  }

  void _navigateToDetail(BuildContext context, RecipeEntity recipe) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RecipeDetailScreen(recipe: recipe),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Start from bottom
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Recipe Demo'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_tll0j4bb.json', // Better cooking/loading animation
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.restaurant,
                        size: 100,
                        color: Colors.orange,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cooking up some recipes...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          } else if (state.status == RecipeStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/B.json', // Placeholder error animation
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  Text(state.errorMessage ?? 'Something went wrong'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<RecipeBloc>().add(GetRecipeEvent()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state.status == RecipeStatus.success) {
            final recipes = state.recipes ?? [];
            if (recipes.isEmpty) {
              return const Center(child: Text('No recipes found.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () => _navigateToDetail(context, recipe),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Hero(
                            tag: 'recipe-image-${recipe.id}',
                            child: Image.network(
                              recipe.image,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.prepTimeMinutes + recipe.cookTimeMinutes} mins',
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber[700],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.rating} (${recipe.reviewCount} reviews)',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: recipe.tags
                                    .take(3)
                                    .map(
                                      (tag) => Chip(
                                        label: Text(
                                          tag,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        backgroundColor: Colors.orange
                                            .withValues(alpha: 0.1),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Press the button to load recipes'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<RecipeBloc>().add(GetRecipeEvent()),
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
