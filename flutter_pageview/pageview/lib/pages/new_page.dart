import 'package:flutter/material.dart';
import 'package:pageview/data/data.dart';

class NewPageScreen extends StatelessWidget {
  const NewPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Scaffold(
      backgroundColor: contentsList[currentIndex].backgroundColor,
      body: const Center(
        child: Text(
          'New page 😁',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 28.5,
          ),
        ),
      ),
    );
  }
}
