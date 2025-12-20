import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';  // Auto-generated file

final getIt = GetIt.instance;  // Global service locator

@InjectableInit()  // Tells injectable to generate code
Future<void> configureDependencies() async {
  await getIt.init();  // Initializes all dependencies
}