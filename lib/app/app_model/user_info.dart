import 'package:get/get.dart';

import '../app_utils/services.dart';

class GetUserInfo{
var userData= UserInfoModel().obs;

// UserInfoModel get userData.value => _userData.value.value;
//
//   set userData.value(UserInfoModel value) {
//     _userData.value.value = value;
//   }
}

class UserInfoModel {
  bool? status;
  Results? results;
  String? msg;

  UserInfoModel({this.status, this.results, this.msg});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Results {
  int? userId;
  dynamic firstName;
  dynamic lastName;
  String? username;
  String? mobile;
  String? email;
  String? avatar;
  String? dob;

  Results(
      {this.userId,
        this.firstName,
        this.lastName,
        this.username,
        this.mobile,
        this.email,
        this.avatar,
        this.dob});

  Results.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    mobile = json['mobile'];
    email = json['email'];
    avatar = json['avatar'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['dob'] = this.dob;
    return data;
  }
}
