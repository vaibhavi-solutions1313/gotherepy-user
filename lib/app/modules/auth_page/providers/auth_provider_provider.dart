import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../app_constants/constants_end_points.dart';

class AuthProviderProvider extends GetConnect {
   Future<http.StreamedResponse> signInUser(String email,String password,String deviceToken)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl + EndPoints().signIn));
    request.body = json.encode({
      "email": email,
      "password": password,
      "device_token": deviceToken
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
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
   Future<http.StreamedResponse> registerNewUser(Map data)async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().signUp));
     request.body = json.encode({
       "username": data['username'],
       "email": data['email'],
       "phone": data['phone'],
       "password": data['password'],
       "confirm_password": data['confirm_password'],
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
return response;
   }


   Future<http.StreamedResponse> verifyNumber(String mob)async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().sendOtp));
     request.body = json.encode({
       "mobile": mob
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     return response;
   }

   Future<http.StreamedResponse> submitOtp(String mob,String otp)async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().verifyOtp));
     request.body = json.encode({
       "mobile": mob,
       "otp": otp
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     return response;
   }
}
