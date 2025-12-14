import 'package:flutter/material.dart';
import 'package:recipe_app/core/di/injection.dart';
import 'package:recipe_app/main.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize(Environment.staging);
    // setup dependency injection
  await configureDependencies();
  runApp(const MyApp());
}