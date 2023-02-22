import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Square Rotate"),
      ),
      body: Center(
          child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,

            /// OR
            /// origin: const Offset(75, 75),
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.indigo,
              ),
              width: 150,
              height: 150,
            ),
          );
        },
      )),
    );
  }
}
