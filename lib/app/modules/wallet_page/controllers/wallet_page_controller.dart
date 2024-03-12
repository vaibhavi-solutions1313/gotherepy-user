import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/constants_appColors.dart';
import '../providers/wallet_provider.dart';

class WalletPageController extends GetxController {
  //TODO: Implement WalletPageController
  ///Instances
  WalletProvider walletProvider = WalletProvider();
  TextEditingController textEditingController = TextEditingController();
  late FlipCardController flipCardController;
  var isVisible = false.obs;
  var walletBalance = '0.0'.obs;

  ///RazorPay
  getBalance() {
    walletProvider.fetchWalletBalance().then((value) async {
      var decodedData = jsonDecode(await value.stream.bytesToString());
      if (decodedData['wallet_details'] != null) {
        Get.find<WalletPageController>().walletBalance.value = decodedData['wallet_details'][0]['amount'].toString();
      }
    });
  }

  Future<void> startPayment(String amount) async {
    flipCardController.toggleCard();
    int amountInRupees = (int.parse(amount)) * 100;
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
    if (kDebugMode) {
      print('paymentId:${response.paymentId.toString()}');
    }
    walletProvider.addAmountToWallet(response.paymentId.toString()).then((paymentResponse) async {
      var decodedPaymentResponse = jsonDecode(await paymentResponse.stream.bytesToString());
      print('-----------------------------addAmountToWallet---paymentResponse-------------------------------------');
      print(decodedPaymentResponse.toString());
      if (decodedPaymentResponse['status'] == true) {
        walletProvider.fetchWalletBalance().then((balanceResponse) async {
          var decodedData = jsonDecode(await balanceResponse.stream.bytesToString());
          if (decodedData['wallet_details'] != null) {
            Get.find<WalletPageController>().walletBalance.value = decodedData['wallet_details'][0]['amount'].toString();
          }
        });

        Get.defaultDialog(
            titlePadding: EdgeInsets.zero,
            title: '',
            content: Container(
              child: Text(
                'Sucess',
                style: TextStyle(color: Colors.black),
              ),
            ));
      }
    });
  }

  void _handlePaymentError(BuildContext context, PaymentFailureResponse response) {
    // Do something when payment fails
    context.loaderOverlay.hide();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  ///Phone pe
  String body = "";
  String callback = "flutterDemoApp";
  String checksum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";

  Map<String, String> headers = {};
  Map<String, String> pgHeaders = {"Content-Type": "application/json"};
  List<String> apiList = <String>['Container', 'PG'];
  List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
  String apiEndPoint = "/pg/v1/pay";
  bool enableLogs = true;
  Object? result;
  String dropdownValue = 'PG';

  String environmentValue = 'UAT_SIM';
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  String packageName = "com.phonepe.simulator";

  phonepeInit() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs).then((val) {
      result = 'PhonePe SDK Initialized - $val';
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startTransaction() {
    dropdownValue == 'Container' ? startContainerTransaction() : startPGTransaction();
  }

  void initPhonePeSdk() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs).then((isInitialized) {
      result = 'PhonePe SDK Initialized - $isInitialized';
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void isPhonePeInstalled() {
    PhonePePaymentSdk.isPhonePeInstalled().then((isPhonePeInstalled) {
      result = 'PhonePe Installed - $isPhonePeInstalled';
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void isGpayInstalled() {
    PhonePePaymentSdk.isGPayAppInstalled().then((isGpayInstalled) {
      result = 'GPay Installed - $isGpayInstalled';
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void isPaytmInstalled() {
    PhonePePaymentSdk.isPaytmAppInstalled().then((isPaytmInstalled) {
      result = 'Paytm Installed - $isPaytmInstalled';
    }).catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void getPackageSignatureForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getPackageSignatureForAndroid().then((packageSignature) {
        result = 'getPackageSignatureForAndroid - $packageSignature';
      }).catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  void getInstalledUpiAppsForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getInstalledUpiAppsForAndroid().then((apps) {
        // if (apps != null) {
        //   Iterable l = json.decode(apps);
        //   List<UPIApp> upiApps = List<UPIApp>.from(
        //       l.map((model) => UPIApp.fromJson(model)));
        //   String appString = '';
        //   for (var element in upiApps) {
        //     appString +=
        //     "${element.applicationName} ${element.version} ${element.packageName}";
        //   }
        //   result = 'Installed Upi Apps - $appString';
        // } else {
        //   result = 'Installed Upi Apps - 0';
        // }
      }).catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  void startPGTransaction() async {
    try {
      PhonePePaymentSdk.startPGTransaction(body, callback, checksum, pgHeaders, apiEndPoint, packageName).then((response) {
        if (kDebugMode) {
          print('88888888888888888888888888888');
        }
        print(response.toString());
        if (response != null) {
          String status = response['status'].toString();
          String error = response['error'].toString();
          if (status == 'SUCCESS') {
            result = "Flow Completed - Status: Success!";
          } else {
            result = "Flow Completed - Status: $status and Error: $error";
          }
        } else {
          result = "Flow Incomplete";
        }
      }).catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    if (error is Exception) {
      result = error.toString();
    } else {
      result = {"error": error};
    }
  }

  void startContainerTransaction() async {
    try {
      PhonePePaymentSdk.startContainerTransaction(body, callback, checksum, headers, apiEndPoint).then((response) {
        if (response != null) {
          String status = response['status'].toString();
          String error = response['error'].toString();
          if (status == 'SUCCESS') {
            result = "Flow Completed - Status: Success!";
          } else {
            result = "Flow Completed - Status: $status and Error: $error";
          }
        } else {
          result = "Flow Incomplete";
        }
      }).catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      result = {"error": error};
    }
  }

  getChecksum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": "https://webhook.site/callback-url",
      "paymentInstrument": {
        "type": "PAY_PAGE",
        // "targetApp": "com.phonepe.app"
      },
      "deviceContext": {"deviceOS": "ANDROID"}
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum = '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    return base64Body;
  }

  @override
  void onInit() {
    super.onInit();
    body = getChecksum().toString();
    phonepeInit();
    flipCardController = FlipCardController();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getBalance();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    razorpay.clear(); // Removes all listeners
  }
  Future startFalseTranscation({required String amount})async{

    await walletProvider.addBalance(amount: amount).then((value) async {
      await getBalance();
      Get.defaultDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: '',
          middleText: '',
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Icon(
                  Icons.wallet,
                  size: 56,
                  color: AppColors.greyTextColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text16by600(
                  text: 'success',
                  fontSize: 20,
                ),
                SizedBox(
                  height: 15,
                ),
                FooterTextWithCenterAligned(
                  text: 'Amount added successfully in your wallet.',
                  fontSize: 16,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
    });

  }
}

