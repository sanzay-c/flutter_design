import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRoute customGoRoute<T>({
  required String path,
  required Widget child,
  GoRouterWidgetBuilder? builder,
  List<RouteBase>? routes,
  GlobalKey<NavigatorState>? parentNavigatorKey,
  GoRouterPageBuilder? pageBuilder,
}) {
  return GoRoute(
    path: path,
    name: path,
    builder: builder,
    routes: routes ?? <RouteBase>[],
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: pageBuilder ??
        (context, state) => MaterialPage<T>(
              key: state.pageKey,
              name: state.name,
              child: child,
            ),
  );
}
