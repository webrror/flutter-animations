import 'package:flutter/material.dart';

class Example5 extends StatefulWidget {
  const Example5({super.key});

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  bool _isZoomedIn = false;
  String _buttonTitle = "Zoom In";
  Icon _buttonIcon = const Icon(Icons.zoom_in_rounded);
  Curve _curve = Curves.bounceOut;
  var _width = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: _curve,
              width: _width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              duration: const Duration(milliseconds: 400),
              child: Image.asset(
                'assets/image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _isZoomedIn = !_isZoomedIn;
              _buttonTitle = _isZoomedIn ? "Zoom Out" : "Zoom In";
              _width = _isZoomedIn ? MediaQuery.of(context).size.width : 100.0;
              _buttonIcon = _isZoomedIn
                  ? const Icon(Icons.zoom_out_rounded)
                  : const Icon(Icons.zoom_in_rounded);

              _curve = _isZoomedIn ? Curves.easeOut : Curves.easeIn;
            });
          },
          icon: _buttonIcon,
          label: Text(_buttonTitle)),
    );
  }
}
