import 'package:app/counter.dart';
import 'package:get/get.dart';
import 'package:app/counter_using_builder.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Counter(),
      // home: CounterUsingBuilder(),
    );
  }
}