class TopThreeDoctorModel {
  bool? status;
  String? msg;
  List<Result>? results;

  TopThreeDoctorModel({this.status, this.msg, this.results});

  TopThreeDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(new Result.fromJson(v));
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

class Result {
  int? id;
  int? doctorId;
  int? userId;
  int? ratings;
  String? review;
  String? createdAt;
  String? updatedAt;
  dynamic fname;
  dynamic lname;
  String? fcmToken;
  String? avatar;
  String? phone;
  dynamic emergencyPhone;
  dynamic dob;
  String? email;
  String? username;
  dynamic userType;
  dynamic otp;
  dynamic otpExpiredAt;
  dynamic emailVerifiedAt;
  String? password;
  dynamic rememberToken;
  int? status;
  int? verifyOtp;
  dynamic subscriptionId;
  dynamic googleId;
  dynamic facebookId;
  int? roleId;
  int? isVerified;
  int? doctorTypeId;
  dynamic rejectReason;
  String? activation;
  int? isOnlineChat;
  int? isOnlineSession;
  String? name;
  String? degree;
  String? title;
  dynamic exp;
  dynamic rate;
  String? idProof;
  String? about;
  String? gender;
  String? educationProof;
  String? doctorTypeName;

  Result(
      {this.id,
        this.doctorId,
        this.userId,
        this.ratings,
        this.review,
        this.createdAt,
        this.updatedAt,
        this.fname,
        this.lname,
        this.fcmToken,
        this.avatar,
        this.phone,
        this.emergencyPhone,
        this.dob,
        this.email,
        this.username,
        this.userType,
        this.otp,
        this.otpExpiredAt,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.status,
        this.verifyOtp,
        this.subscriptionId,
        this.googleId,
        this.facebookId,
        this.roleId,
        this.isVerified,
        this.doctorTypeId,
        this.rejectReason,
        this.activation,
        this.isOnlineChat,
        this.isOnlineSession,
        this.name,
        this.degree,
        this.title,
        this.exp,
        this.rate,
        this.idProof,
        this.about,
        this.gender,
        this.educationProof,
        this.doctorTypeName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    ratings = json['ratings'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fname = json['fname'];
    lname = json['lname'];
    fcmToken = json['fcm_token'];
    avatar = json['avatar'];
    phone = json['phone'];
    emergencyPhone = json['emergency_phone'];
    dob = json['dob'];
    email = json['email'];
    username = json['username'];
    userType = json['user_type'];
    otp = json['otp'];
    otpExpiredAt = json['otp_expired_at'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    status = json['status'];
    verifyOtp = json['verify_otp'];
    subscriptionId = json['subscription_id'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    roleId = json['role_id'];
    isVerified = json['is_verified'];
    doctorTypeId = json['doctor_type_id'];
    rejectReason = json['reject_reason'];
    activation = json['activation'];
    isOnlineChat = json['is_online_chat'];
    isOnlineSession = json['is_online_session'];
    name = json['name'];
    degree = json['degree'];
    title = json['title'];
    exp = json['exp'];
    rate = json['rate'];
    idProof = json['id_proof'];
    about = json['about'];
    gender = json['gender'];
    educationProof = json['education_proof'];
    doctorTypeName = json['doctor_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['ratings'] = this.ratings;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['fcm_token'] = this.fcmToken;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['emergency_phone'] = this.emergencyPhone;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['otp'] = this.otp;
    data['otp_expired_at'] = this.otpExpiredAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['status'] = this.status;
    data['verify_otp'] = this.verifyOtp;
    data['subscription_id'] = this.subscriptionId;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['role_id'] = this.roleId;
    data['is_verified'] = this.isVerified;
    data['doctor_type_id'] = this.doctorTypeId;
    data['reject_reason'] = this.rejectReason;
    data['activation'] = this.activation;
    data['is_online_chat'] = this.isOnlineChat;
    data['is_online_session'] = this.isOnlineSession;
    data['name'] = this.name;
    data['degree'] = this.degree;
    data['title'] = this.title;
    data['exp'] = this.exp;
    data['rate'] = this.rate;
    data['id_proof'] = this.idProof;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['education_proof'] = this.educationProof;
    data['doctor_type_name'] = this.doctorTypeName;
    return data;
  }
}
