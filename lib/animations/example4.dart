import 'package:flutter/material.dart';

const people = [
  Person(name: "John", age: 20, emoji: '👨🏼‍🦰'),
  Person(name: "Amy", age: 20, emoji: '👮🏽'),
  Person(name: "James", age: 20, emoji: '👨🏼'),
];

class Example4 extends StatelessWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Animation"),
      ),
      body: ListView.builder(
        itemCount: people.length,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemBuilder: (context, index) {
          final person = people[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(person: person),
                    ));
              },
              leading: Hero(
                tag: person.name,
                child: Text(
                  person.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              title: Text(person.name),
              subtitle: (Text("${person.age} years old")),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          );
        },
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0, end: 1)
                          .chain(CurveTween(curve: Curves.fastOutSlowIn)),
                    ),
                    child: toHeroContext.widget);

              // Wasnt needed in my case, returning worked fine
              // return Material(
              //   color: Colors.transparent,
              //   child: toHeroContext.widget,
              // );

              case HeroFlightDirection.pop:
                return fromHeroContext.widget;

              // Wasnt needed in my case, returning worked fine
              // return Material(
              //   color: Colors.transparent,
              //   child: fromHeroContext.widget,
              // );
            }
          },
          tag: person.name,
          child: Material(
            color: Colors.transparent,
            child: Text(
              person.emoji,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              person.name,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              "${person.age} years old",
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}
