class ChatListModel {
  bool? status;
  String? msg;
  List<Results>? results;

  ChatListModel({this.status, this.msg, this.results});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? patientName;
  int? doctorId;
  int? userId;
  String? avatar;
  String? doctorName;
  String? message;

  Results(
      {this.patientName,
        this.doctorId,
        this.userId,
        this.avatar,
        this.doctorName,
        this.message});

  Results.fromJson(Map<String, dynamic> json) {
    patientName = json['patient_name'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    avatar = json['avatar'];
    doctorName = json['doctor_name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_name'] = this.patientName;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['doctor_name'] = this.doctorName;
    data['message'] = this.message;
    return data;
  }
}
