import 'package:flutter/material.dart';
import 'dart:math';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);

    path.close();

    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class SemiCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const SemiCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> with TickerProviderStateMixin {
  late AnimationController _counterClockWiseRotationController;
  late Animation<double> _counterClockWiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    // Counter clock wise animation

    _counterClockWiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockWiseRotationAnimation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(CurvedAnimation(
            parent: _counterClockWiseRotationController,
            curve: Curves.bounceOut));

    // flip animation

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    // status listeners

    _counterClockWiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterClockWiseRotationAnimation = Tween<double>(
                begin: _counterClockWiseRotationAnimation.value,
                end: _counterClockWiseRotationAnimation.value + -(pi / 2))
            .animate(CurvedAnimation(
                parent: _counterClockWiseRotationController,
                curve: Curves.bounceOut));

        _counterClockWiseRotationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _counterClockWiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockWiseRotationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chained Animation"),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: AnimatedBuilder(
          animation: _counterClockWiseRotationAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_counterClockWiseRotationAnimation.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper:
                              const SemiCircleClipper(side: CircleSide.left),
                          child: Container(
                            width: 150,
                            height: 150,
                            color: Colors.indigo,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper:
                              const SemiCircleClipper(side: CircleSide.right),
                          child: Container(
                            width: 150,
                            height: 150,
                            color: Colors.amber,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
