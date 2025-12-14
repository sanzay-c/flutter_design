import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/constants/app_color.dart';

class StatusError extends StatelessWidget {
  final String text;
  final double? size;

  const StatusError({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(
            Icons.error_outline_outlined,
            size: size ?? 48.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.errorColor,
            ),
          ),
          16.verticalSpace,
          Text(
            text,
            textAlign: .center,
            style: TextStyle(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
