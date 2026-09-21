import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/view/screens/gameplay.dart';


class Scores extends StatefulWidget {
  const Scores({super.key, required this.title});

  final String title;

  @override
  State<Scores> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Scores> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return buildScores();
  }

  Scaffold buildScores()
  {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text("Latest Best Scores"),
            ],
          ),
        )
      );
  }

}