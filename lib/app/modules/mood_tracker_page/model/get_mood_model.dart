// To parse this JSON data, do
//
//     final getMoodModel = getMoodModelFromJson(jsonString);

import 'dart:convert';

GetMoodModel getMoodModelFromJson(String str) => GetMoodModel.fromJson(json.decode(str));

String getMoodModelToJson(GetMoodModel data) => json.encode(data.toJson());

class GetMoodModel {
  bool? status;
  String? msg;
  List<Record>? records;

  GetMoodModel({
    this.status,
    this.msg,
    this.records,
  });

  factory GetMoodModel.fromJson(Map<String, dynamic> json) => GetMoodModel(
    status: json["status"],
    msg: json["msg"],
    records: json["records"] == null ? [] : List<Record>.from(json["records"]!.map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "records": records == null ? [] : List<dynamic>.from(records!.map((x) => x.toJson())),
  };
}

class Record {
  int? id;
  String? color;
  String? moodType;
  String? icon;

  Record({
    this.id,
    this.color,
    this.moodType,
    this.icon,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    color: json["color"],
    moodType: json["mood_type"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "mood_type": moodType,
    "icon": icon,
  };
}
