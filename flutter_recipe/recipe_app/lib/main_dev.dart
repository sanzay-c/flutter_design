import 'package:flutter/material.dart';
import 'package:recipe_app/core/di/injection.dart';
import 'package:recipe_app/main.dart';
import 'core/config/env_config.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async operation
  WidgetsFlutterBinding.ensureInitialized(); 

  // Initialize environment configuration for 'dev' (development) environment
  await EnvConfig.initialize(Environment.dev); 

  // setup dependency injection
  await configureDependencies();

  // Run the app by passing the root widget (MyApp)
  runApp(const MyApp()); 
}