// import 'dart:convert';

// import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';

// class RecipeModel {
//   List<Recipe> recipes;
//   int total;
//   int skip;
//   int limit;

//   RecipeModel({
//     required this.recipes,
//     required this.total,
//     required this.skip,
//     required this.limit,
//   });

//   factory RecipeModel.fromRawJson(String str) =>
//       RecipeModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
//     recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
//     total: json["total"],
//     skip: json["skip"],
//     limit: json["limit"],
//   );

//   Map<String, dynamic> toJson() => {
//     "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
//     "total": total,
//     "skip": skip,
//     "limit": limit,
//   };
// }

// class Recipe {
//   int id;
//   String name;
//   List<String> ingredients;
//   List<String> instructions;
//   int prepTimeMinutes;
//   int cookTimeMinutes;
//   int servings;
//   Difficulty difficulty;
//   String cuisine;
//   int caloriesPerServing;
//   List<String> tags;
//   int userId;
//   String image;
//   double rating;
//   int reviewCount;
//   List<String> mealType;

//   Recipe({
//     required this.id,
//     required this.name,
//     required this.ingredients,
//     required this.instructions,
//     required this.prepTimeMinutes,
//     required this.cookTimeMinutes,
//     required this.servings,
//     required this.difficulty,
//     required this.cuisine,
//     required this.caloriesPerServing,
//     required this.tags,
//     required this.userId,
//     required this.image,
//     required this.rating,
//     required this.reviewCount,
//     required this.mealType,
//   });

//   factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
//     id: json["id"],
//     name: json["name"],
//     ingredients: List<String>.from(json["ingredients"].map((x) => x)),
//     instructions: List<String>.from(json["instructions"].map((x) => x)),
//     prepTimeMinutes: json["prepTimeMinutes"],
//     cookTimeMinutes: json["cookTimeMinutes"],
//     servings: json["servings"],
//     difficulty: difficultyValues.map[json["difficulty"]]!,
//     cuisine: json["cuisine"],
//     caloriesPerServing: json["caloriesPerServing"],
//     tags: List<String>.from(json["tags"].map((x) => x)),
//     userId: json["userId"],
//     image: json["image"],
//     rating: json["rating"]?.toDouble(),
//     reviewCount: json["reviewCount"],
//     mealType: List<String>.from(json["mealType"].map((x) => x)),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
//     "instructions": List<dynamic>.from(instructions.map((x) => x)),
//     "prepTimeMinutes": prepTimeMinutes,
//     "cookTimeMinutes": cookTimeMinutes,
//     "servings": servings,
//     "difficulty": difficultyValues.reverse[difficulty],
//     "cuisine": cuisine,
//     "caloriesPerServing": caloriesPerServing,
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "userId": userId,
//     "image": image,
//     "rating": rating,
//     "reviewCount": reviewCount,
//     "mealType": List<dynamic>.from(mealType.map((x) => x)),
//   };

//   RecipeEntity toEntity() {
//     return RecipeEntity(
//       id: id,
//       name: name,
//       ingredients: ingredients,
//       instructions: instructions,
//       prepTimeMinutes: prepTimeMinutes,
//       cookTimeMinutes: cookTimeMinutes,
//       servings: servings,
//       difficulty: difficulty,
//       cuisine: cuisine,
//       caloriesPerServing: caloriesPerServing,
//       tags: tags,
//       userId: userId,
//       image: image,
//       rating: rating,
//       reviewCount: reviewCount,
//       mealType: mealType,
//     );
//   }
// }

// enum Difficulty { EASY, MEDIUM }

// final difficultyValues = EnumValues({
//   "Easy": Difficulty.EASY,
//   "Medium": Difficulty.MEDIUM,
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

// lib/data/models/recipe_model.dart




// import 'package:recipe_app/core/enum/difficulty.dart';
// import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';

// class Recipe {
//   int id;
//   String name;
//   List<String> ingredients;
//   List<String> instructions;
//   int? prepTimeMinutes;        // ✅ Nullable
//   int? cookTimeMinutes;        // ✅ Nullable
//   int? servings;               // ✅ Nullable
//   Difficulty? difficulty;      // ✅ Nullable
//   String? cuisine;             // ✅ Nullable
//   int? caloriesPerServing;     // ✅ Nullable
//   List<String>? tags;          // ✅ Nullable
//   int? userId;                 // ✅ Nullable
//   String? image;               // ✅ Nullable
//   double? rating;              // ✅ Nullable
//   int? reviewCount;            // ✅ Nullable
//   List<String>? mealType;      // ✅ Nullable

//   Recipe({
//     required this.id,
//     required this.name,
//     required this.ingredients,
//     required this.instructions,
//     this.prepTimeMinutes,
//     this.cookTimeMinutes,
//     this.servings,
//     this.difficulty,
//     this.cuisine,
//     this.caloriesPerServing,
//     this.tags,
//     this.userId,
//     this.image,
//     this.rating,
//     this.reviewCount,
//     this.mealType,
//   });

//   factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
//         id: json["id"],
//         name: json["name"],
//         ingredients: List<String>.from(json["ingredients"].map((x) => x)),
//         instructions: List<String>.from(json["instructions"].map((x) => x)),
//         // ✅ All optional fields - won't crash if null
//         prepTimeMinutes: json["prepTimeMinutes"],
//         cookTimeMinutes: json["cookTimeMinutes"],
//         servings: json["servings"],
//         difficulty: json["difficulty"] != null
//             ? difficultyValues.map[json["difficulty"]]
//             : null,
//         cuisine: json["cuisine"],
//         caloriesPerServing: json["caloriesPerServing"],
//         tags: json["tags"] != null
//             ? List<String>.from(json["tags"].map((x) => x))
//             : null,
//         userId: json["userId"],
//         image: json["image"],
//         rating: json["rating"]?.toDouble(),
//         reviewCount: json["reviewCount"],
//         mealType: json["mealType"] != null
//             ? List<String>.from(json["mealType"].map((x) => x))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
//         "instructions": List<dynamic>.from(instructions.map((x) => x)),
//         if (prepTimeMinutes != null) "prepTimeMinutes": prepTimeMinutes,
//         if (cookTimeMinutes != null) "cookTimeMinutes": cookTimeMinutes,
//         if (servings != null) "servings": servings,
//         if (difficulty != null)
//           "difficulty": difficultyValues.reverse[difficulty],
//         if (cuisine != null) "cuisine": cuisine,
//         if (caloriesPerServing != null) "caloriesPerServing": caloriesPerServing,
//         if (tags != null) "tags": List<dynamic>.from(tags!.map((x) => x)),
//         if (userId != null) "userId": userId,
//         if (image != null) "image": image,
//         if (rating != null) "rating": rating,
//         if (reviewCount != null) "reviewCount": reviewCount,
//         if (mealType != null)
//           "mealType": List<dynamic>.from(mealType!.map((x) => x)),
//       };

//   RecipeEntity toEntity() {
//     return RecipeEntity(
//       id: id,
//       name: name,
//       ingredients: ingredients,
//       instructions: instructions,
//       prepTimeMinutes: prepTimeMinutes ?? 0,         // ✅ Default value
//       cookTimeMinutes: cookTimeMinutes ?? 0,         // ✅ Default value
//       servings: servings ?? 0,                       // ✅ Default value
//       difficulty: difficulty ?? Difficulty.EASY,     // ✅ Default value
//       cuisine: cuisine ?? "",                        // ✅ Default value
//       caloriesPerServing: caloriesPerServing ?? 0,   // ✅ Default value
//       tags: tags ?? [],                              // ✅ Default value
//       userId: userId ?? 0,                           // ✅ Default value
//       image: image ?? "",                            // ✅ Default value
//       rating: rating ?? 0.0,                         // ✅ Default value
//       reviewCount: reviewCount ?? 0,                 // ✅ Default value
//       mealType: mealType ?? [],                      // ✅ Default value
//     );
//   }
// }


import 'dart:convert';

import 'package:recipe_app/core/enum/difficulty.dart';
import 'package:recipe_app/features/recipe_feature/domain/entities/recipe_entity.dart';

class RecipeModel {
  List<Recipe> recipes;
  int total;
  int skip;
  int limit;

  RecipeModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipeModel.fromRawJson(String str) =>
      RecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Recipe {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int? prepTimeMinutes;        // ✅ Nullable
  int? cookTimeMinutes;        // ✅ Nullable
  int? servings;               // ✅ Nullable
  Difficulty? difficulty;      // ✅ Nullable
  String? cuisine;             // ✅ Nullable
  int? caloriesPerServing;     // ✅ Nullable
  List<String>? tags;          // ✅ Nullable
  int? userId;                 // ✅ Nullable
  String? image;               // ✅ Nullable
  double? rating;              // ✅ Nullable
  int? reviewCount;            // ✅ Nullable
  List<String>? mealType;      // ✅ Nullable

  Recipe({
    required this.id,
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
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        // ✅ All optional fields - won't crash if null
        prepTimeMinutes: json["prepTimeMinutes"],
        cookTimeMinutes: json["cookTimeMinutes"],
        servings: json["servings"],
        difficulty: json["difficulty"] != null
            ? difficultyValues.map[json["difficulty"]]
            : null,
        cuisine: json["cuisine"],
        caloriesPerServing: json["caloriesPerServing"],
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : null,
        userId: json["userId"],
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        reviewCount: json["reviewCount"],
        mealType: json["mealType"] != null
            ? List<String>.from(json["mealType"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        if (prepTimeMinutes != null) "prepTimeMinutes": prepTimeMinutes,
        if (cookTimeMinutes != null) "cookTimeMinutes": cookTimeMinutes,
        if (servings != null) "servings": servings,
        if (difficulty != null)
          "difficulty": difficultyValues.reverse[difficulty],
        if (cuisine != null) "cuisine": cuisine,
        if (caloriesPerServing != null) "caloriesPerServing": caloriesPerServing,
        if (tags != null) "tags": List<dynamic>.from(tags!.map((x) => x)),
        if (userId != null) "userId": userId,
        if (image != null) "image": image,
        if (rating != null) "rating": rating,
        if (reviewCount != null) "reviewCount": reviewCount,
        if (mealType != null)
          "mealType": List<dynamic>.from(mealType!.map((x) => x)),
      };

  RecipeEntity toEntity() {
    return RecipeEntity(
      id: id,
      name: name,
      ingredients: ingredients,
      instructions: instructions,
      prepTimeMinutes: prepTimeMinutes ?? 0,         // ✅ Default value
      cookTimeMinutes: cookTimeMinutes ?? 0,         // ✅ Default value
      servings: servings ?? 0,                       // ✅ Default value
      difficulty: difficulty ?? Difficulty.EASY,     // ✅ Default value
      cuisine: cuisine ?? "",                        // ✅ Default value
      caloriesPerServing: caloriesPerServing ?? 0,   // ✅ Default value
      tags: tags ?? [],                              // ✅ Default value
      userId: userId ?? 0,                           // ✅ Default value
      image: image ?? "",                            // ✅ Default value
      rating: rating ?? 0.0,                         // ✅ Default value
      reviewCount: reviewCount ?? 0,                 // ✅ Default value
      mealType: mealType ?? [],                      // ✅ Default value
    );
  }
}