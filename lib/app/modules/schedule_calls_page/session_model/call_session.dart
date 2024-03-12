class CallSessionModel {
  bool? status;
  String? msg;
  List<Results>? results;

  CallSessionModel({this.status, this.msg, this.results});

  CallSessionModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? appointmentNumber;
  int? counsellingId;
  int? doctorId;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  String? cancelledBy;
  int? cancelledById;
  String? status;
  dynamic reason;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? degree;
  String? title;
  int? exp;
  int? rate;
  String? idProof;
  String? about;
  String? gender;
  String? avatar;
  dynamic educationProof;

  Results(
      {this.id,
        this.userId,
        this.appointmentNumber,
        this.counsellingId,
        this.doctorId,
        this.bookingDate,
        this.bookingStartTime,
        this.bookingEndTime,
        this.cancelledBy,
        this.cancelledById,
        this.status,
        this.reason,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.degree,
        this.title,
        this.exp,
        this.rate,
        this.idProof,
        this.about,
        this.gender,
        this.avatar,
        this.educationProof});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    appointmentNumber = json['appointment_number'];
    counsellingId = json['counselling_id'];
    doctorId = json['doctor_id'];
    bookingDate = json['booking_date'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    cancelledBy = json['cancelled_by'];
    cancelledById = json['cancelled_by_id'];
    status = json['status'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    degree = json['degree'];
    title = json['title'];
    exp = json['exp'];
    rate = json['rate'];
    idProof = json['id_proof'];
    about = json['about'];
    gender = json['gender'];
    avatar = json['avatar'];
    educationProof = json['education_proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['appointment_number'] = this.appointmentNumber;
    data['counselling_id'] = this.counsellingId;
    data['doctor_id'] = this.doctorId;
    data['booking_date'] = this.bookingDate;
    data['booking_start_time'] = this.bookingStartTime;
    data['booking_end_time'] = this.bookingEndTime;
    data['cancelled_by'] = this.cancelledBy;
    data['cancelled_by_id'] = this.cancelledById;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['degree'] = this.degree;
    data['title'] = this.title;
    data['exp'] = this.exp;
    data['rate'] = this.rate;
    data['id_proof'] = this.idProof;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['education_proof'] = this.educationProof;
    return data;
  }
}
