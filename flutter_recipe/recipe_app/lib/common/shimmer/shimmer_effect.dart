import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double? height;
  final double? width;

  const ShimmerEffect({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: getColorByTheme(context: context, colorClass: AppColors.baseColorShimmer),
      highlightColor: getColorByTheme(context: context, colorClass: AppColors.highlightColorShimmer),
      child: Container(
        color: getColorByTheme(context: context, colorClass: AppColors.containerColorShimmer),
        height: height ?? 20,
        width: width ?? double.infinity,  
      ),
    );
  }
}
