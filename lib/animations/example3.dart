import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Example3 extends StatefulWidget {
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3> with TickerProviderStateMixin {
  final widthHeight = 100.0;

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _yController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _zController =
        AnimationController(vsync: this, duration: const Duration(seconds: 50));

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cube Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation:
              Listenable.merge([_xController, _yController, _zController]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_animation.evaluate(_xController))
                ..rotateY(_animation.evaluate(_yController))
                ..rotateZ(_animation.evaluate(_zController)),
              child: Stack(
                children: [
                  // front
                  Container(
                    color: Colors.redAccent,
                    width: widthHeight,
                    height: widthHeight,
                    child: const Center(child: Text("1")),
                  ),
                  // back

                  //left
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2),
                    child: Container(
                      color: Colors.blueAccent,
                      width: widthHeight,
                      height: widthHeight,
                      child: const Center(child: Text("2")),
                    ),
                  ),

                  //right
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2),
                    child: Container(
                      color: Colors.teal,
                      width: widthHeight,
                      height: widthHeight,
                      child: const Center(child: Text("3")),
                    ),
                  ),

                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(Vector3(0, 0, -widthHeight)),
                    child: Container(
                      color: Colors.grey,
                      width: widthHeight,
                      height: widthHeight,
                      child: const Center(child: Text("4")),
                    ),
                  ),

                  //top
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2),
                    child: Container(
                      color: Colors.orange,
                      width: widthHeight,
                      height: widthHeight,
                      child: const Center(child: Text("5")),
                    ),
                  ),

                  //bottom
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2),
                    child: Container(
                      color: Colors.red,
                      width: widthHeight,
                      height: widthHeight,
                      child: const Center(child: Text("6")),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
