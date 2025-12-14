import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/core/di/injection.config.dart';

final getIt = GetIt.instance; 

@InjectableInit()  // Tells injectable to generate code
Future<void> configureDependencies() async {
  await getIt.init();  // Initializes all dependencies
}