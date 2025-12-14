// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_color.dart';

class RecipeTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  final String? hintText;
  final int? maxLines;
  final InputBorder? border;
  final String? Function(String?)? validator;

  const RecipeTextFormField({
    Key? key,
    required this.controller,
    this.text,
    this.hintText,
    this.maxLines,
    this.border,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 3,
      decoration: InputDecoration(
        labelText: text,
        hintText: hintText,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.textFieldColor,
            ),
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: validator,
    );
  }
}
