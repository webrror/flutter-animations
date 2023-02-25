import 'package:anim1/animations/example1.dart';
import 'package:anim1/animations/example2.dart';
import 'package:anim1/animations/example4.dart';
import 'package:anim1/animations/example5.dart';
import 'package:anim1/animations/example6.dart';
import 'package:flutter/material.dart';

import 'animations/example3.dart';

/* 
  0.0 = 0 degrees
  0.5 = 180 degrees
  1.0 = 360 degrees

  ! pi = 180

*/

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    home: const Router(),
    routes: {
      '/e1':(context) => const Example1(),
      '/e2': (context) => const Example2(),
      '/e3': (context) => const Example3(),
      '/e4': (context) => const Example4(),
      '/e5': (context) => const Example5(),
      '/e6': (context) => const Example6()
    },
  ));
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Examples"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e1');
              },
              title: const Text("Square Rotate"),
              subtitle: const Text("Example 1"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e2');
              },
              title: const Text("Chained Animation"),
              subtitle: const Text("Example 2"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e3');
              },
              title: const Text("Cube Animation"),
              subtitle: const Text("Example 3"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e4');
              },
              title: const Text("Hero Animation"),
              subtitle: const Text("Example 4"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e5');
              },
              title: const Text("Implicit Animations"),
              subtitle: const Text("Example 5"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                Navigator.pushNamed(context, '/e6');
              },
              title: const Text("Random Color"),
              subtitle: const Text("Example 6"),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          )
        ],
      ),
    );
  }
}
