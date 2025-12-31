import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app/core/socket/socket_service.dart';
import 'package:posts_app/features/chat_app_socket/presentation/bloc/chat_bloc.dart';
import 'package:posts_app/features/chat_app_socket/presentation/bloc/chat_event.dart';
import 'package:posts_app/features/chat_app_socket/socket_chat_screen.dart';
import 'package:posts_app/features/form-validation-bloc/bloc/form_validation_bloc.dart';
import 'package:posts_app/features/form-validation-bloc/registration_screen.dart';
import 'package:posts_app/features/socket/data/datasource/socket_datasource.dart';
import 'package:posts_app/features/socket/data/repo_impl.dart/socket_repo_impl.dart';
import 'package:posts_app/features/socket/presentation/bloc/socket_bloc.dart';
import 'package:posts_app/features/socket/presentation/bloc/socket_event.dart' hide ConnectSocket;
import 'package:posts_app/features/socket/presentation/screens/chat_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => FormValidationBloc()),
            BlocProvider(create: (context) =>  ChatBloc(SocketService())..add(ConnectSocket() as ChatEvent)),  
            BlocProvider(
              create: (context) =>
                  SocketBloc(SocketRepoImpl(SocketDatasource())),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: RegistrationScreen(),
            home: SocketChatScreen(),
          ),
        );
      },
    );
  }
}
