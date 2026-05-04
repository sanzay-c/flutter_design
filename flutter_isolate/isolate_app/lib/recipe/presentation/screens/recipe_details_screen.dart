import 'package:flutter/material.dart';
import 'package:isolate_app/recipe/domain/entities/recipe_entity.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeEntity recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'recipe-image-${recipe.id}',
              child: Image.network(
                recipe.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(' ${recipe.rating} (${recipe.reviewCount} reviews)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...recipe.ingredients.map((item) => Text('• $item')),
                  const SizedBox(height: 16),
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...recipe.instructions.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('${entry.key + 1}. ${entry.value}'),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
