import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
class ProfileInfoProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<http.StreamedResponse>fetchUserInfo()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-profile'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
  Future<http.StreamedResponse> getProfileInfo()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-profile'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

    }
    else {
    print(response.reasonPhrase);
    }
    return response;
  }
  Future<http.StreamedResponse> updateImage(String imagePath)async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/change-profile-pic'));
    request.files.add(await http.MultipartFile.fromPath('avatar', imagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
  Future<http.StreamedResponse> updateUserProfile(Map data)async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/profile'));
    request.body = json.encode({
      "fname": data['fname'],
      "lname": data['lname'],
      "dob": data['dob']
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }
  Future<http.StreamedResponse> changePassword(Map data)async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/password-change'));
    request.body = json.encode({
      "old_pass": data['oldPassword'],
      "new_pass": data['newPassword'],
      "conf_pass": data['newConfirmedPassword']
    });
    print( data['oldPassword']);
    print( data['newPassword']);
    print( data['newConfirmedPassword']);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }

}
