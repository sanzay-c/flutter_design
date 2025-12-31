import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    // very dark - app bar + drawer color
    surface: Color.fromARGB(255, 9, 9, 9),

    // slightly dark
    primary: Color.fromARGB(255, 105, 105, 105),

    // dark
    secondary: Color.fromARGB(255, 20, 20, 20),

    // slightly dart
    tertiary: Color.fromARGB(255, 29, 29, 29),

    // very light
    inversePrimary: Color.fromARGB(255, 195, 195, 195),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 9, 9, 9),

  // textTheme: GoogleFonts.montserratTextTheme(), // Use Open Sans
);
