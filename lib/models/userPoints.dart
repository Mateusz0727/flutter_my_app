// ignore_for_file: file_names

class UserPointsModel {
  final int points;
  final int countOfPrize;

  UserPointsModel({
    required this.points,
    required this.countOfPrize,
  });
  UserPointsModel.fromJson(Map<String, dynamic> json)
      : points = json['points'] as int,
        countOfPrize = json['countOfPrize'] as int;
}
