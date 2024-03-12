import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../app_constants/constants_end_points.dart';
import '../providers/plans_provider.dart';
class PlanAndPricingController extends GetxController {
  //TODO: Implement PlanAndPricingController
  ///Provider
  PlansProvider plansProvider= PlansProvider();


  ///My Plans View
  getPlanHistory()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-subscription'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }


  /// Buy Plans View
  Future plansList()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-plans'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData=jsonDecode(await response.stream.bytesToString());
    return responseData;
  }
  Future<dynamic>getBalance()async{
    return plansProvider.fetchWalletBalance();
  }
  Future<dynamic> purchaseAPlan()async{
    return plansProvider.buyAPlan();
  }

  ///RazorPay
  Future<void> startPayment(String amount)async {
    int amountInRupees=(int.parse(amount))*100;
    var options = {
      'key': EndPoints().razorpayKey,
      'amount': amountInRupees,
      // 'order_id': Random().nextInt(8).toString(),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.open(options);
  }
  Razorpay razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    purchaseAPlan().then((value) async{
      var decodedData=jsonDecode(await value.stream.bytesToString());
      if (kDebugMode) {
        print(decodedData);
      }
      Fluttertoast.showToast(msg: decodedData['msg']);
    });

  }
  void _handlePaymentError(BuildContext context,PaymentFailureResponse response) {
    // Do something when payment fails
    context.loaderOverlay.hide();
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }



  @override
  void onInit() {
    getPlanHistory();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
