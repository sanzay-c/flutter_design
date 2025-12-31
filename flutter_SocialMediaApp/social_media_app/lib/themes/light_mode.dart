import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade300,
    tertiary: Colors.grey.shade100,
    inversePrimary: Colors.grey.shade900,
    onSecondary: Colors.white, // white color
  ),
  scaffoldBackgroundColor: Color(0xFFFAFAFA),

  textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.light().textTheme), // Use Open Sans
  primarySwatch: Colors.blue,
);
