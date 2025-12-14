import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/bloc/theme_bloc.dart';
import 'package:recipe_app/core/di/injection.dart';
import 'package:recipe_app/core/routing/route_config.dart';
import 'package:recipe_app/features/recipe_feature/presentation/bloc/recipe_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider<RecipeBloc>(create: (context) => getIt<RecipeBloc>()),
            BlocProvider(create: (_) => getIt<ThemeBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode, 
                theme: ThemeData.light(),          // Light theme
                darkTheme: ThemeData.dark(), 
                routerConfig: router,
              );
            },
          ),
        );
      },
    );
  }
}
