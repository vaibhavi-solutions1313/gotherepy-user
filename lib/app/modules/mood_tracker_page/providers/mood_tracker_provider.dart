import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;

class MoodTrackerProvider extends GetConnect{
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = "YOUR_API_URL";
    // httpClient.baseUrl = "http://gotherapy.care/backend/public/api/user";
  }

  Future apiGetMoods() async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-moods'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData = jsonDecode(await response.stream.bytesToString());
    print(responseData['records'].toString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future apiGetUserMoods() async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-moods'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData = jsonDecode(await response.stream.bytesToString());
    print(responseData['records'].toString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future apiAddUserMood(String moodId, String date, String time) async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/add-user-moods'));
    request.body = json.encode({
      "mood_id": moodId,
      "date": date,
      "time": time
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
}