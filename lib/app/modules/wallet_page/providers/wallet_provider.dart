import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/modules/wallet_page/controllers/wallet_page_controller.dart';
import 'package:http/http.dart' as http;

class WalletProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<http.StreamedResponse> addAmountToWallet(String orderId) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/add-wallet-money'));
    request.body = json.encode({"razorpay_payment_id": orderId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchWalletBalance() async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-wallet-balance'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   return response;
  }
  Future<http.StreamedResponse> addBalance({required String amount}) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/add-wallet-money'));
    request.fields.addAll({
      'amount': amount
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }
}
