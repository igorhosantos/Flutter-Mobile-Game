import 'dart:convert';
import 'package:mobilegame/service/account/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

class UserAccountFromLocalDisk implements UserAccount {
 
  final String storeId = "scores";

  @override
  Future<List<ScoreRegistry>> fetchBestScores() async {
    
    try {
     
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? serializedScores = sharedPreferences.getString(storeId);

      //means the score does not exist, so it needs to be created the first structure
      if(serializedScores?.isEmpty ?? true) {

        final emptyList = List<ScoreRegistry>.empty();
        final String jsonString = jsonEncode(emptyList);

        await sharedPreferences.setString(storeId, jsonString);

        return emptyList;
      }
      
      final List<dynamic> rawData = jsonDecode(serializedScores!) as List<dynamic>;
      List<ScoreRegistry> scores = rawData.map((item) => ScoreRegistry.fromJson(item as Map<String, dynamic>))
      .toList();

      //order by the best
      if(scores.length>1)
      {
        scores.sort((a, b) => b.score.compareTo(a.score));
      }

      return scores;

    } catch (e) {
      
      print('fetchBestScores An error occurred: $e');
      return List<ScoreRegistry>.empty();
    }

  }

  @override
  Future<void> postScores(ScoreRegistry newScore) async {
    
    try {
      
      //@todo get the latest scores and check if it's a top tier for 
      //putting on the list
      List<ScoreRegistry> currentScores = await fetchBestScores();
      currentScores.add(newScore);

      List<Map<String, dynamic>> jsonList = currentScores.map((score) => score.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(storeId, jsonString);

    } catch (e) {
      // Handle any type of exception
      print('postScores An error occurred: $e');
    }

   
  }

  @override
  Future<void> postClearScores() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(storeId);
  }

}

