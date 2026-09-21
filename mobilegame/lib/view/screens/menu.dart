import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/view/screens/gameplay.dart';


class Menu extends StatefulWidget {
  const Menu({super.key, required this.title});

  final String title;

  @override
  State<Menu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Menu> {
  int _counter = 0;

  void enterTheGame() {
    print("Enter in the game");

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
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Game Menu'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: enterTheGame,
              child: Text("Play"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: enterTheGame,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}