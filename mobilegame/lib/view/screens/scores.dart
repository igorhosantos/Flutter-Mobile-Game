import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return buildScores();
  }

  Scaffold buildScores()
  {

    final userAccount = locator<UserAccount>();
    final fontStyle = GoogleFonts.audiowide(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 241, 239, 239),
                    );
  
    return Scaffold(
          body: FutureBuilder<List<ScoreRegistry>>(
          future: userAccount.fetchBestScores(), // Your async function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } 
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } 
            else if (snapshot.hasData) {
              return Container(
                      margin: const EdgeInsets.only(top: 100.0), // Adds space above the column
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Best Scores', style: fontStyle),
                        ),
                        Expanded(
                          child: createScoreList(snapshot.data),
                        ),
                      ],
                    ),
              ); 
            }
            else {
              return Center(child: Text('No data found'));
            }
          },
        ),
      );
  }

  ListView createScoreList(List<ScoreRegistry>? scoreList){
    return ListView.builder(
        shrinkWrap: true, // Forces the ListView to occupy only the space it needs
        scrollDirection: Axis.vertical, // Or Axis.horizontal
        itemCount: scoreList?.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 50,
            color: (index>0) ?  Colors.green[700]: Color(0xFFFFD700)  ,
            child: Center(child: Text('Score: ${scoreList![index].score} in ${scoreList![index].date}',
             style: TextStyle(color:(index>0) ?  Colors.white : Colors.black)),),
          );
        }
    );
  } 

}