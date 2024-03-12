import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;
class CounsellingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future getCounsellorsBySubCategory(int id)async{
    var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-counselling/$id'));
    http.StreamedResponse response = await request.send();
    var decodedData=jsonDecode(await response.stream.bytesToString());
return decodedData;
  }
}
