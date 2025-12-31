import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/themes/dark_mode.dart';
import 'package:social_media_app/themes/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData>{
  bool _isdarkMode = false;

  ThemeCubit() : super(themeData); // here the themeData actually means the 'light Mode'

  bool get isdarkMode => _isdarkMode;
  
  void toggleTheme(){
    _isdarkMode = !_isdarkMode;

    if(isdarkMode){
      emit(darkMode);
    }else{
      emit(themeData);
    }
  }
}