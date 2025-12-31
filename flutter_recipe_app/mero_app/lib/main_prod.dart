import 'package:flutter/material.dart';
import 'package:mero_app/core/di/injection.dart';
import 'package:mero_app/main.dart';
import 'config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize(Environment.prod);
  await configureDependencies();
  runApp(const MyApp());
}