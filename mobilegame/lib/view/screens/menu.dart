import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/service/account/user_account.dart';
import 'package:mobilegame/service/utils/service_locator.dart';
import 'package:mobilegame/view/screens/gameplay.dart';
import 'package:mobilegame/view/screens/scores.dart';


class Menu extends StatefulWidget {
  const Menu({super.key, required this.title});

  final String title;

  @override
  State<Menu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Menu> {
  
  late Gameplay _gameplayInstance;

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
              ),
              ElevatedButton(
                onPressed: clearScores,
                child: Text("Clear Scores")
              )
            ],
          ),
        )
      );
  }

  void enterTheGame() {
    _gameplayInstance = Gameplay();
    _gameplayInstance.onGameOver = onGameOver;
    
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __){
        return Stack(
          children: [
            GameWidget(game: _gameplayInstance,),
           ],
        ); 
        
      }
    );
  }

  void onGameOver()
  {
      final score = _gameplayInstance.score; 
      trySaveLatestScore(context, score).ignore();
  }

  Future<void> trySaveLatestScore(BuildContext context,  int latestScore) async{
    
    print("Latest Score Saved Async : ${latestScore}");

    final userAccount = locator<UserAccount>();
    userAccount.postScores(ScoreRegistry(latestScore, DateTime.now())).ignore();

    Navigator.pop(context);
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

  void clearScores() {
    final userAccount = locator<UserAccount>();
    userAccount.postClearScores().ignore();
  }
}