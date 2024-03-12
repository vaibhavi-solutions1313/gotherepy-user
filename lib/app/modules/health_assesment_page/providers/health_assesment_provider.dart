import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
class HealthAssesmentProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future getQuestions()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    print('AcessToken:${EndPoints.accessToken}');
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/health-score-question'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var decodedData=jsonDecode(await response.stream.bytesToString());
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    print(decodedData.toString());
return decodedData['records']['health'];
  }

  Future saveAnswer()async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/health-score-submit'));
    request.body = json.encode({
      "health_score": [
        {
          "question_id": "1",
          "answer_id": "5"
        },
        {
          "question_id": "5",
          "answer_id": "8"
        }
      ]
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

  Future<http.StreamedResponse> fetchQuizes()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-question-categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   return response;

  }
  Future<http.StreamedResponse> fetchQuestions({required String questionsId})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-quiz-que-ans'));
    request.fields.addAll({
      'category_id': questionsId
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   return response;

  }
}
