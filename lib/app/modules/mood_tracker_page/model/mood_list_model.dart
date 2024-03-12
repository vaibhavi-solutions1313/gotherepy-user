// To parse this JSON data, do
//
//     final moodListModel = moodListModelFromJson(jsonString);

import 'dart:convert';

MoodListModel moodListModelFromJson(String str) => MoodListModel.fromJson(json.decode(str));

String moodListModelToJson(MoodListModel data) => json.encode(data.toJson());

class MoodListModel {
  bool? status;
  String? msg;
  List<Result>? results;

  MoodListModel({
    this.status,
    this.msg,
    this.results,
  });

  factory MoodListModel.fromJson(Map<String, dynamic> json) => MoodListModel(
    status: json["status"],
    msg: json["msg"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? moodColor;
  String? moodType;
  String? icon;
  DateTime? publishDate;
  String? publishTime;

  Result({
    this.id,
    this.moodColor,
    this.moodType,
    this.icon,
    this.publishDate,
    this.publishTime,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    moodColor: json["mood_color"],
    moodType: json["mood_type"],
    icon: json["icon"],
    publishDate: json["publish_date"] == null ? null : DateTime.parse(json["publish_date"]),
    publishTime: json["publish_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mood_color": moodColor,
    "mood_type": moodType,
    "icon": icon,
    "publish_date": "${publishDate!.year.toString().padLeft(4, '0')}-${publishDate!.month.toString().padLeft(2, '0')}-${publishDate!.day.toString().padLeft(2, '0')}",
    "publish_time": publishTime,
  };
}
