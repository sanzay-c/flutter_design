import 'package:flutter/material.dart';
import 'package:get_app/presentation/bindings/app_binding.dart';
import 'package:get_app/presentation/screens/venue_screens.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding:AppBindings(),
      home: VenueScreens(),
    );
  }
}
