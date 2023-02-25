import 'package:flutter/material.dart';
import 'dart:math' as math;

class CicleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final oval = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(oval);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/*

  A R G B
  A = Alpha ( 0 - 255 )
  R = Red ( 0 - 255 )
  G = Green ( 0 - 255 )
  B = Blue ( 0 - 255 )

 */

Color randomColor() => Color(0xFF000000 + math.Random().nextInt(0xFFFFFFFF));

class Example6 extends StatefulWidget {
  const Example6({super.key});

  @override
  State<Example6> createState() => _Example6State();
}

class _Example6State extends State<Example6> {
  var color = randomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Color"),
      ),
      body: Center(
        child: ClipPath(
          clipper: CicleClipper(),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            tween: ColorTween(begin: randomColor(), end: color),
            onEnd: () {
              setState(() {
                color = randomColor();
              });
            },
            builder: (context, value, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(value!, BlendMode.color),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 1.5,
                  color: Colors.greenAccent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
