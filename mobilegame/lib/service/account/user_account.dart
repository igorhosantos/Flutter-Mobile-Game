import 'package:json_annotation/json_annotation.dart';

abstract class UserAccount {
  Future<List<ScoreRegistry>> fetchBestScores();
  Future postScores(ScoreRegistry newScore);
  Future postClearScores();
}


@JsonSerializable()
class ScoreRegistry{
  final String  score;
  final String  date;

  ScoreRegistry(this.score, this.date);

  ScoreRegistry.fromJson(Map<String, dynamic> json)
    : score = json['score'],
      date = json['date'];

  Map<String, dynamic> toJson() => {'score': score, 'date': date};

}
