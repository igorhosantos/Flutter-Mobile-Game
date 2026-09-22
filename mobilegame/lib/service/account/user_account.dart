import 'package:json_annotation/json_annotation.dart';

abstract class UserAccount {
  Future<List<ScoreRegistry>> fetchBestScores();
  Future postScores(ScoreRegistry newScore);
  Future postClearScores();
}


@JsonSerializable()
class ScoreRegistry{
  final int score;
  final DateTime date;

  ScoreRegistry(this.score, this.date);

  ScoreRegistry.fromJson(Map<String, dynamic> json)
    : score = json['score'] as int,
      date = DateTime.parse(json['date'] as String);

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'date': date.toIso8601String(), // Converts DateTime to a standardized string format
    };
  }

}
