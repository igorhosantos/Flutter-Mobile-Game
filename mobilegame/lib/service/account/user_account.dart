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
      date = json['date'] as DateTime;

  Map<String, dynamic> toJson() => {'score': score, 'date': date};

}
