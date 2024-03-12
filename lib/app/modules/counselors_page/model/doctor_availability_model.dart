class DoctorAvailabilitySlotsModel {
  bool? status;
  String? msg;
  Results? results;

  DoctorAvailabilitySlotsModel({this.status, this.msg, this.results});

  DoctorAvailabilitySlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  List<String>? time;

  Results({this.time});

  Results.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }
}
