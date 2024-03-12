import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
import '../../../app_model/therapists.dart';
class AllBookedTherapistsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

 Future<List<Results>> fetchAllBookedTherapists({required String userId})async {
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-chat-sessions'));
    request.fields.addAll({
      'user_id': userId
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    List<Results> result=[];
    if (response.statusCode == 200) {
      var data= jsonDecode(await response.stream.bytesToString());
      result=List.from(data).map<Results>((e) => Results.fromJson(e)).toList();
      // result=Results.fromJson(data['results']);
      return result;
    }
    else {
    print(response.reasonPhrase);
    return result;
    }

  }
}
