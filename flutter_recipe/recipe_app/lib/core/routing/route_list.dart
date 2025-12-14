import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/routing/custom_go_route.dart';
import 'package:recipe_app/core/routing/route_name.dart';
import 'package:recipe_app/features/recipe_feature/presentation/screens/add_recipe_screen.dart';
import 'package:recipe_app/features/recipe_feature/presentation/screens/recipe_detail_screen.dart';
import 'package:recipe_app/features/recipe_feature/presentation/screens/recipe_screen.dart';


// List<RouteBase> get otherRouteList => [
//   customGoRoute(
//     path: RouteName.otherRoute,
//     child: const OtherScreen(),
//   ),
// ];

List<RouteBase> get recipeRouteList => [
  customGoRoute(
    path: RouteName.recipeScreen,
    child: const RecipeScreen(),
  ),
  customGoRoute(
    path: RouteName.recipeDetailsScreen,
    child: const RecipeDetailsScreen(),
  ),
  customGoRoute(
    path: RouteName.addNewRecipeScreen,
    child: const AddRecipeScreen(),
  ),
];