import 'package:flutter/material.dart';
import 'package:mobilegame/view/screens/menu.dart';

void main() {
  runApp(const MainGame());
}

class MainGame extends StatelessWidget {
  const MainGame({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Menu(title: 'Flutter Demo Home Page'),
    );
  }
}


