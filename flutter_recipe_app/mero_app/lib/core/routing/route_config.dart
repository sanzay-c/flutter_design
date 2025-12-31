import 'package:go_router/go_router.dart';
import 'package:mero_app/core/routing/navigation_service.dart';
import 'package:mero_app/core/routing/route_list.dart';
import 'package:mero_app/core/routing/route_name.dart';

GoRouter get router => GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      initialLocation: RouteName.recipeScreen,
      routes: [
        ...recipeRouteList,
        // ...uiTemplateRouteList,
      ],
    );
