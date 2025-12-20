import 'package:go_router/go_router.dart';
import 'package:posts_app/core/routing/navigation_services.dart';
import 'package:posts_app/core/routing/route_list.dart';
import 'package:posts_app/core/routing/route_name.dart';


GoRouter get router => GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      initialLocation: RouteName.postsScreen, //initial screen to show first
      routes: [
        ...PostsRouteList,
        // ...otherRouteList,
      ],
    );