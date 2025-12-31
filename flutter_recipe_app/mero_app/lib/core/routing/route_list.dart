import 'package:go_router/go_router.dart';
import 'package:mero_app/core/routing/custom_go_route.dart';
import 'package:mero_app/core/routing/route_name.dart';
import 'package:mero_app/presentation/screens/recipe_detail_screen.dart';
import 'package:mero_app/presentation/screens/recipe_screen.dart';

// List<RouteBase> get uiTemplateRouteList => [
//   customGoRoute(
//     path: RouteName.uiTemplateRoute,
//     child: const UITemplateScreen(),
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
];
