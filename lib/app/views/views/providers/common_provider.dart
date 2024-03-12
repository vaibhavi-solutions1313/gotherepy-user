import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
class CommonProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<dynamic> moodList()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-moods'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData=jsonDecode(await response.stream.bytesToString());
    print(responseData.toString());
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
return responseData['records'];
  }
  userMoodHistory()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-moods'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
  Future updateUserMood({required String moodId,required String date,required String time,})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/add-user-moods'));
    request.body = json.encode({
      "mood_id": "1",
      "date": "2023-05-23",
      "time": "05:45"
    });
    // request.body = json.encode({
    //   "mood_id": moodId,
    //   "date": date,
    //   // "time": time
    // });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
      // print(response.reasonPhrase);
    }
    return response;

  }
}
