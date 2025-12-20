import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app/features/form-validation-bloc/bloc/form_validation_bloc.dart';
import 'package:posts_app/features/form-validation-bloc/registration_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => FormValidationBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: RegistrationScreen(),
          ),
        );
      },
    );
  }
}
