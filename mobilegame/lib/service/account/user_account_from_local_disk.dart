import 'dart:convert';

import 'package:mobilegame/service/account/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

class UserAccountFromLocalDisk implements UserAccount {
 
  final String storeId = "scores";

  @override
  Future<List<ScoreRegistry>> fetchBestScores() async {
    
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? serializedScores = sharedPreferences.getString(storeId);

    if(serializedScores?.isEmpty ?? true) {
      return List<ScoreRegistry>.empty();
    }
    

    final List<ScoreRegistry> scores = jsonDecode(serializedScores!);
    return scores; 
  }

  @override
  Future<void> postScores(ScoreRegistry newScore) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    //@todo get the latest scores and check if it's a top tier for 
    //putting on the list

    final List<ScoreRegistry> currentScores = await fetchBestScores();
    currentScores.add(newScore);

    final String jsonString = jsonEncode(currentScores);
    
    await sharedPreferences.setString(storeId, jsonString);
  }

  @override
  Future<void> postClearScores() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(storeId);
  }

}

