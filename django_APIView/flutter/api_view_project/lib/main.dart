import 'package:api_view_project/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  theme: ThemeData.dark().copyWith(
      //   // You can customize the dark theme further if needed
      //   primaryColor: Colors.blueGrey, // Custom primary color
      //   hintColor: Colors.amber, // Custom accent color
      //   buttonTheme: ButtonThemeData(buttonColor: Colors.amber), // Custom button color
      //   // You can also customize text themes and other aspects
      //   textTheme: TextTheme(
      //     titleLarge: TextStyle(color: Colors.white),
      //     titleMedium: TextStyle(color: Colors.white),
      //   ),
      // ),
      theme: ThemeData(
        // Set Poppins font globally
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,  // Inherit other theme settings
        ),
      ),
      home: HomePage(),
    );
  }  
}
