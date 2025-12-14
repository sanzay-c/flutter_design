import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_app/common/model/color_model.dart';

class AppColors {
  AppColors._();

  static ColorModel backgroundColor = ColorModel(
    lightModeColor: const Color(0xFFFFFFFF),
    darkModeColor: Colors.black,
  );

  static ColorModel highlightColorShimmer = ColorModel(
    lightModeColor: const Color.fromARGB(255, 169, 169, 169),
    darkModeColor: const Color.fromARGB(255, 169, 169, 169),
  );

  static ColorModel baseColorShimmer = ColorModel(
    lightModeColor: const Color.fromARGB(255, 169, 169, 169),
    darkModeColor: const Color.fromARGB(255, 169, 169, 169),
  );

  static ColorModel containerColorShimmer = ColorModel(
    lightModeColor: const Color.fromARGB(255, 206, 206, 206),
    darkModeColor: const Color.fromARGB(255, 206, 206, 206),
  );

  static ColorModel errorColor = ColorModel(
    lightModeColor: const Color.fromARGB(255, 254, 0, 0),
    darkModeColor: const Color.fromARGB(255, 254, 0, 0),
  );

  static ColorModel textFieldColor = ColorModel(
    lightModeColor: Colors.black,
    darkModeColor: Colors.white,
  );

  static ColorModel cardColor = ColorModel(
    lightModeColor: const Color(0xFFFAFAFA),
    darkModeColor: const Color(0xFF1F1F1F),
  );

  static ColorModel btnColor = ColorModel(
    lightModeColor: const Color.fromARGB(255, 0, 0, 0),
    darkModeColor: const Color.fromARGB(255, 92, 92, 92),
  );

  static ColorModel btnTextColor = ColorModel(
    lightModeColor: const Color.fromARGB(255, 255, 255, 255),
    darkModeColor: const Color.fromARGB(255, 0, 0, 0),
  );
  static ColorModel containerBorderColor = ColorModel(
    lightModeColor: Colors.grey,
    darkModeColor: Colors.white,
  );
  static ColorModel profileBoxColor = ColorModel(
    lightModeColor: Colors.white,
    darkModeColor: Colors.black,
  );
  static ColorModel profileIconColor = ColorModel(
    lightModeColor: Colors.grey,
    darkModeColor: Colors.white,
  );
  static ColorModel profileTextColor = ColorModel(
    lightModeColor: Colors.black,
    darkModeColor: Colors.white,
  );
  static ColorModel bottomNavColor = ColorModel(
    lightModeColor:Color.fromARGB(156, 255, 255, 255)
,
    darkModeColor: const Color.fromARGB(151, 0, 0, 0),
  );
  static ColorModel textColor = ColorModel(
    lightModeColor: const Color.fromRGBO(0, 0, 0, 1),
    darkModeColor: Colors.white,
  );
  static ColorModel buttonBorderSide = ColorModel(
    lightModeColor: Colors.black,
    darkModeColor: Colors.white,
  );
  static ColorModel selectedIndex = ColorModel(
    lightModeColor: Color(0xFF48319D),
    darkModeColor: Colors.white,
  );
  static ColorModel unSelectedIndex = ColorModel(
    lightModeColor: const Color.fromARGB(255, 71, 70, 70),
    darkModeColor: const Color.fromARGB(255, 255, 255, 255),
  );
}

extension ThemeContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

Color getColorByTheme({
  required BuildContext context,
  required ColorModel? colorClass,
  Color fallbackLight = Colors.black,
  Color fallbackDark = Colors.white,
}) {
  final isDark = context.isDark;
  if (colorClass == null) return isDark ? fallbackDark : fallbackLight;
  return isDark ? colorClass.darkModeColor : colorClass.lightModeColor;
}
