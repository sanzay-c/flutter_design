import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/constants/app_color.dart';

class Content extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;

  const Content({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textOverflow,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? getColorByTheme(context: context, colorClass: AppColors.textColor),
        fontSize: fontSize?.sp ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
        overflow: textOverflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
