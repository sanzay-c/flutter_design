import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/pages/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // supabase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://cdhjeiztxcgmspqtxzei.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkaGplaXp0eGNnbXNwcXR4emVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwNDU2MTEsImV4cCI6MjA0NjYyMTYxMX0.2Fo5dZR39gPPjlAWSi6HGO_xWiBsdQmUB_oh0zGUUDk",
  );

  // runapp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const NotePage(),
    );
  }
}

//eWr8SU6ihm8yRh31 - this is password