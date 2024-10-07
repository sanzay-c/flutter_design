

import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  double x = 0;
  double y = 0;
  double z = 0;
  double height = 200;
  double width = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Transform(
                transform: Matrix4(
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  0,
                  0,
                  0,
                  1,
                )
                  ..rotateX(x)
                  ..rotateY(x)
                  ..rotateZ(z),
                alignment: FractionalOffset.center,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      y = y + details.delta.dx / 100;
                      x = x + details.delta.dy / 100;
                    });
        
                    print('::::${y}');
                    print('::::${x}');
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.amberAccent,
                    child: Image.network(
                        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"),
                  ),
                  // Text("hello world", style: TextStyle(fontSize: 80),)
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 30, 
                ),
                height: height,
                width: width,
                color: Colors.redAccent,
              ),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    height = 300;
                    width = 200;
                  });
                },
                child: const Text(
                  'Change Me',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
