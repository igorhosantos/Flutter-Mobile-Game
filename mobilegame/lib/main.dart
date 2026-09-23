import 'package:flutter/material.dart';
import 'package:mobilegame/service/utils/service_locator.dart';
import 'package:mobilegame/view/screens/menu.dart';

void main() {
  setupLocator(); 
  
  runApp(const MainGame());
}

class MainGame extends StatelessWidget {
  const MainGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spaceship Survivor',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Menu(title: 'Spaceship \n Survivor'),
    );
  }
}


