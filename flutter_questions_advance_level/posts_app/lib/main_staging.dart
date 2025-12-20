import 'package:flutter/material.dart';
import 'package:posts_app/core/di/injection.dart';
import 'package:posts_app/main.dart';
import 'config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize(Environment.staging);
  await configureDependencies();
  runApp(const MyApp());
}