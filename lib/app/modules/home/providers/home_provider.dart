import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/main.dart';
import 'package:http/http.dart' as http;

import '../../../app_model/therapists.dart';
import '../../../app_utils/notification_services.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  sendNotification() {
    NotificationServices notificationServices = NotificationServices();
    var headers = {
      'Authorization':
          'key=AAAAXg5J3KU:APA91bE9oXMoRxOnW1I1JqLYjenUeAYSGd--0DAAMh9J5X4Etl5xcEs7ad7-xxKgJpqQfXnISED2ml2ozWOwMlgGuPIHoVnraVpiVpScSamfy3UEUPm_6F50-YiR5cBK7J0Quu1vqJ7r',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    notificationServices.getDeviceToken().then((value) async {
      request.body = json.encode({
        "to": value,
        "notification": {"body": "Body of Your Notification", "title": "Title of Your Notification"}
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print('notification sent');
      } else {
        print(response.reasonPhrase);
      }
    });
  }

  Future fetchBanner() async {
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-banner'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('==================================banner=====================================');
      var decodedData = jsonDecode(await response.stream.bytesToString());
      if (kDebugMode) {
        print('777777777777777777777777777777788877777777777777777777777777');
      }
      Get.find<HomeController>().bannersList.value = decodedData['records'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<String> fetchDoctorTypes() async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-doctor-types'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return await response.stream.bytesToString();
  }

  Future<Rx<Therapists>> fetchDoctorListByDoctorType(String doctorType) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-doctor-by-type'));
    request.body = json.encode({"doctor_type_id": doctorType.isNotEmpty ? doctorType : "1"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Rx<Therapists>? decodedData = Therapists().obs;
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      if (data['results'] != '') {
        decodedData.value = Therapists.fromJson(data);
        return decodedData;
      } else {
         decodedData.value = Therapists();
      }
    }
    return decodedData;
  }

  Future fetchDoctorBanner() async {
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/doctor/get-doctor-banner'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('777777777777777777777777777777777777777777777777777777777');
      }
      var decodedData = jsonDecode(await response.stream.bytesToString());
      Get.find<HomeController>().doctorBannersList.value = decodedData['records'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getCounselling() async {
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-counselling'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(await response.stream.bytesToString());
      Get.find<HomeController>().counsellingList.value = decodedData['records'];
    } else {
      print(response.reasonPhrase);
    }
  }
}
