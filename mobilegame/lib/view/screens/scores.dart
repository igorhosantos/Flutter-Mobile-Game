import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/service/account/user_account.dart';
import 'package:mobilegame/service/utils/service_locator.dart';
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

    final userAccount = locator<UserAccount>();

  
    return Scaffold(
          body: FutureBuilder<String>(
          future: userAccount.fetchData(), // Your async function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Center(child: Column(
            mainAxisAlignment: .center,
            children: [
              Text("Latest Best Scores: ${snapshot.data}."),
            ],
          ),);
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ),
      );
  }

}