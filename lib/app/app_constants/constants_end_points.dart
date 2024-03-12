import 'package:get/get.dart';
import '../app_utils/services.dart';

class EndPoints{
  static String netWorkImage='https://picsum.photos/200';
  static String imageBaseUrl='http://gotherapy.care/backend/public/';
  static String baseUrl='http://gotherapy.care/backend/public/api/user/';
  static String accessToken=Get.find<Services>().box.read('accessToken')??'';
  static Future<void> getAccessToken()async{
    accessToken=Get.find<Services>().box.read('accessToken');
  }

  ///auth
   String signIn='login';
   String signUp='register';
   String sendOtp='resend-otp';
   String verifyOtp='verify-otp';
   String resetPassword='https://picsum.photos/200';

  ///Wallet
  String getWalletDetail='https://picsum.photos/200';
  String walletUpdateApi='https://picsum.photos/200';
  String addBalanceWalletApi='https://picsum.photos/200';

  ///Google services & FIREBASE PUSH NOTIFICATION account detail
    //TODO : CHANGE/REPLACE ADDED ACCOUNT
    //-ADDED ACCOUNT:bikramsinghflutter@gmail.com,pwd:Bikram@1313
  String googleRoutesKey='https://picsum.photos/200';
  //Login with facebook
  // email:bikramsinghflutter@gmail.com,
  // pwd:Bikram@1313
  String fb='https://picsum.photos/200';

  ///Razorpay payment info
  // loginCredential: 8083434142;
  // String razorpayKey='rzp_test_rnCOHMNNTBmwnx';
  String razorpayKey='rzp_test_bfHFr2Gt3dzQ2F';
  String razorpaySecretKey='B5YcJRMWE1nT11BvYNPSzrMh';
}