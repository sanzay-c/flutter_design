import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mero_app/core/di/injection.dart';
import 'package:mero_app/core/global_data/global_theme/bloc/theme_bloc.dart';
import 'package:mero_app/core/routing/route_config.dart';
import 'package:mero_app/presentation/bloc/recipe_bloc.dart';
// import 'package:mero_app/presentation/screens/recipe_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
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
                darkTheme: ThemeData.dark(),       // Dark theme
                routerConfig: router,
                // home: const RecipeScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
