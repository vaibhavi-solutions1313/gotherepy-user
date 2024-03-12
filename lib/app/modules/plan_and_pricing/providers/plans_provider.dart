import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
class PlansProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<dynamic> fetchWalletBalance()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-wallet-balance'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var decodedData=jsonDecode(await response.stream.bytesToString());
    return decodedData;
  }
  Future<http.StreamedResponse>buyAPlan()async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/buy-subscription'));
    request.body = json.encode({
      "plan_id": "1"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
