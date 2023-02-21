import 'package:anim1/animations/example1.dart';
import 'package:anim1/animations/example2.dart';
import 'package:flutter/material.dart';

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
      '/e2':(context) => const Example2()
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
          )
        ],
      ),
    );
  }
}
