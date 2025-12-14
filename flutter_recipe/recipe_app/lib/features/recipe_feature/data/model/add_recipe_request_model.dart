// lib/data/models/add_recipe_request_model.dart
import 'dart:convert';

class AddRecipeRequestModel {
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final String? difficulty;
  final String? cuisine;
  final int? caloriesPerServing;
  final List<String>? tags;
  final String? image;
  final List<String>? mealType;

  AddRecipeRequestModel({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.image,
    this.mealType,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
    };

    // Optional fields (only add if not null)
    if (prepTimeMinutes != null) data['prepTimeMinutes'] = prepTimeMinutes;
    if (cookTimeMinutes != null) data['cookTimeMinutes'] = cookTimeMinutes;
    if (servings != null) data['servings'] = servings;
    if (difficulty != null) data['difficulty'] = difficulty;
    if (cuisine != null) data['cuisine'] = cuisine;
    if (caloriesPerServing != null) data['caloriesPerServing'] = caloriesPerServing;
    if (tags != null && tags!.isNotEmpty) data['tags'] = tags;
    if (image != null) data['image'] = image;
    if (mealType != null && mealType!.isNotEmpty) data['mealType'] = mealType;

    return data;
  }

  String toRawJson() => json.encode(toJson());
}