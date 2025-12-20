import 'package:flutter/material.dart';
import 'package:posts_app/core/di/injection.dart';
import 'package:posts_app/main.dart';
import 'config/env_config.dart';

void main() async {
  // Ensure Flutter bindings are initialized before any async operation
  WidgetsFlutterBinding.ensureInitialized(); 

  // Initialize environment configuration for 'dev' (development) environment
  await EnvConfig.initialize(Environment.dev); 

  await configureDependencies();

  // Run the app by passing the root widget (MyApp)
  runApp(const MyApp()); 
}