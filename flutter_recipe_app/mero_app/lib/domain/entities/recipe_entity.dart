
import 'package:mero_app/data/models/recipe_model.dart';

class RecipeEntity {
   int id;
    String name;
    List<String> ingredients;
    List<String> instructions;
    int prepTimeMinutes;
    int cookTimeMinutes;
    int servings;
    Difficulty difficulty;
    String cuisine;
    int caloriesPerServing;
    List<String> tags;
    int userId;
    String image;
    double rating;
    int reviewCount;
    List<String> mealType;
    
  RecipeEntity({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });
}
