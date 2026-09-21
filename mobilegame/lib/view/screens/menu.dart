import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/view/screens/gameplay.dart';
import 'package:mobilegame/view/screens/scores.dart';


class Menu extends StatefulWidget {
  const Menu({super.key, required this.title});

  final String title;

  @override
  State<Menu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Menu> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return buildMenu();
  }

  Scaffold buildMenu()
  {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(widget.title),
              ElevatedButton(
                onPressed: enterTheGame,
                child: Text("Play")
              ),
              ElevatedButton(
                onPressed: enterTheScores,
                child: Text("Scores")
              )
            ],
          ),
        )
      );
  }

  void enterTheGame() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __){
        return Stack(
          children: [
            GameWidget(game: Gameplay(),),
            Positioned(
              right: 20,
              top: 80,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.cancel_outlined))
              ) 
            ],
        ); 
        
      }
    );
  }

  void enterTheScores() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __){
        return Stack(
          children: [
            Scores(title: "Scores"),
            Positioned(
              right: 20,
              top: 80,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.cancel_outlined))
              ) 
            ],
        ); 
        
      }
    );
  }
}