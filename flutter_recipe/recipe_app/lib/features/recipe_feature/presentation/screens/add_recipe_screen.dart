import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/appbar/recipe_appbar.dart';
import 'package:recipe_app/common/widgets/content.dart';
import 'package:recipe_app/common/widgets/recipe_text_form_field.dart';
import 'package:recipe_app/core/constants/app_color.dart';
import 'package:recipe_app/features/recipe_feature/data/model/add_recipe_request_model.dart';
import 'package:recipe_app/features/recipe_feature/presentation/bloc/recipe_bloc.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _cuisineController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _cuisineController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submitRecipe() {
    if (_formKey.currentState!.validate()) {
      final ingredients = _ingredientsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final instructions = _instructionsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final request = AddRecipeRequestModel(
        name: _nameController.text,
        ingredients: ingredients,
        instructions: instructions,
        cuisine: _cuisineController.text.isNotEmpty
            ? _cuisineController.text
            : null,
        image: _imageController.text.isNotEmpty ? _imageController.text : null,
      );

      context.read<RecipeBloc>().add(AddRecipeEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: RecipeAppBar(title: "Add New Recipe"),
      body: BlocListener<RecipeBloc, RecipeDataState>(
        listenWhen: (previous, current) {
          // Only listen when status changes
          return previous.status != current.status;
        },
        listener: (context, state) {
          // FIXED: Check for recipeAdded status
          if (state.status == RecipeStatus.recipeAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recipe added successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                elevation: 4,
                duration: Duration(seconds: 2),
              ),
            );

            // Safe navigation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            });
          } else if (state.status == RecipeStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error adding recipe'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<RecipeBloc, RecipeDataState>(
          builder: (context, state) {
            final isLoading = state.status == RecipeStatus.loading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name Field
                    RecipeTextFormField(
                      controller: _nameController,
                      text: "Recipe Name *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter recipe name';
                        }
                        return null;
                      },
                    ),

                    16.verticalSpace,

                    // Ingredients Field
                    RecipeTextFormField(
                      controller: _ingredientsController,
                      text: 'Ingredients (comma separated) *',
                      hintText: 'e.g., chicken, curry powder, coconut milk',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ingredients';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,

                    RecipeTextFormField(
                      controller: _instructionsController,
                      text: 'Instructions (comma separated) *',
                      hintText: 'e.g., Cook chicken, Add spices, Simmer',
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter instructions';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    RecipeTextFormField(
                      controller: _cuisineController,
                      text: 'Cuisine (optional)',
                      hintText: 'e.g., Indian, Italian',
                    ),

                    16.verticalSpace,

                    RecipeTextFormField(
                      controller: _imageController,
                      text: 'Image URL (optional)',
                      hintText: 'https://example.com/image.jpg',
                    ),

                    24.verticalSpace,

                    // Submit Button
                    ElevatedButton(
                      onPressed: isLoading ? null : _submitRecipe,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: getColorByTheme(context: context, colorClass: AppColors.btnColor),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Content(
                              text: "Add Recipe",
                              fontSize: 16.sp,
                              color: getColorByTheme(context: context, colorClass: AppColors.btnTextColor),
                              fontWeight: FontWeight.normal,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
