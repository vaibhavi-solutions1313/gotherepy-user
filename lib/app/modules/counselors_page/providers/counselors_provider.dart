import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app_constants/constants_end_points.dart';
import '../../../app_model/conversation.dart';
import '../controllers/counselors_page_controller.dart';

class CounselorsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<dynamic> fetchSlotsAvailability({required String doctorId, required String date,required String timeType}) async {


    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-time-slots'));
    request.body = json.encode({"doc_id": doctorId, "date": date,"time_type":timeType});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(await response.stream.bytesToString());
      return decodedData;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future bookSlot({required String doctorId,
    required String bookingDate,
    required String bookingTimeSlot,
    required num doctorCharge}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    print({
      "booking_type": "session",
      "booking_date": bookingDate,
      "booking_time": bookingTimeSlot,
      "doc_id": doctorId,
      "amount": doctorCharge
    });
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/book-appointment'));
      request.body = json.encode({
        "booking_type": "session",
        "booking_date": bookingDate,
        "booking_time": bookingTimeSlot,
        "doc_id": doctorId,
        "amount": doctorCharge
      });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
      var jsonDecodedData=jsonDecode(await response.stream.bytesToString());
      print(jsonDecodedData);
    await Fluttertoast.showToast(msg: jsonDecodedData['message'] ?? jsonDecodedData['msg'], gravity: ToastGravity.CENTER);
  }

  Future<Rx<Conversation>> fetchConversation({required String userId, required String doctorId})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-messages'));
    request.fields.addAll({
      'user_id': userId,
      'doctor_id': doctorId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Rx<Conversation> conversation=Conversation().obs;
    if (response.statusCode == 200) {
      print('======================fetchConversation=success========================');
      print(doctorId);
      print(userId);
      var data=jsonDecode(await response.stream.bytesToString());
      conversation.value=Conversation.fromJson(data);
      return conversation;
    }
    else {
      print(response.reasonPhrase);
      return conversation;
    }

  }
  Future sendMessage({required String userId, required String doctorId, required String message, int isDoctorUser=0})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/send-message'));
    request.fields.addAll({
      'user_id': userId,
      'doctor_id': doctorId,
      'message': message,
      'is_doctor_user': isDoctorUser.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<http.StreamedResponse> requestChatBookingAppointment({required String chatTime,required int doctorId,required String amount,})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/book-appointment'));
    request.body = json.encode({
      "booking_type": "chat",
      "chat_time": chatTime,
      "doc_id": doctorId,
      "amount": amount
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;

  }

}
