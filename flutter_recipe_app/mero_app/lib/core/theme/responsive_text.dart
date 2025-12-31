import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveTextStyle {
  static TextStyle get title => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get body => TextStyle(
        fontSize: 14.sp,
      );

  static TextStyle get small => TextStyle(
        fontSize: 12.sp,
        color: Colors.grey,
      );
}
