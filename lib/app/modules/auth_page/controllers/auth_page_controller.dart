import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/app_utils/services.dart';
import 'package:gotherepy/app/modules/auth_page/views/auth_page_view.dart';
import 'package:gotherepy/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../main.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_model/user_info.dart';
import '../../../app_utils/notification_services.dart';
import '../../home/views/home_view.dart';
import '../providers/auth_provider_provider.dart';
import '../views/verification_page_view.dart';

class AuthPageController extends GetxController {
  NotificationServices notificationServices = NotificationServices();
  AuthProviderProvider authProvider = AuthProviderProvider();
  var isClicked = false.obs;

  //TODO: Implement AuthPageController
  ///Sign In
  final signInFormKey = GlobalKey<FormState>();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPhoneController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  signIn(String email, String password, BuildContext context) {
    context.loaderOverlay.show();
    notificationServices.getDeviceToken().then((deviceToken) {
      authProvider.signInUser(email, password, deviceToken).then((response) async {
        context.loaderOverlay.hide();
        var decodedData = jsonDecode(await response.stream.bytesToString());
        if (decodedData['status'] == true) {
          Get.find<Services>().box.write('accessToken', decodedData['token']);
          EndPoints.getAccessToken().whenComplete(() async {
            await Get.find<SplashScreenController>().getAllData();
            await authProvider.fetchUserInfo().then((resValue) async {
              context.loaderOverlay.hide();
              var userDecodedData = jsonDecode(await resValue.stream.bytesToString());
              Get.find<Services>().box.write('userInfo', userDecodedData);
              userInfo.userData.value = UserInfoModel.fromJson(Get.find<Services>().box.read('userInfo'));
              // userInfo.userData.value=UserInfoModel.fromJson(userDecodedData);
              Get.to(() => const HomeView());
            });
          });
        } else {
          Fluttertoast.showToast(msg: decodedData['message'], backgroundColor: AppColors.tealColor);
        }
      });
    });
  }

  ///Get User Information
  Future getUserInfo() {
    return authProvider.fetchUserInfo();
  }

  ///Sign Up
  final signUpFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  registerNewUser(Map data, BuildContext context) {
    context.loaderOverlay.show();
    authProvider.registerNewUser(data).then((response) async {
      context.loaderOverlay.hide();
      var decodedData = jsonDecode(await response.stream.bytesToString());
      print('=========================================registerNewUser===================================================');
      print(decodedData.toString());
      if (decodedData['status'] == true) {
        sendOtp(context, data['phone']);
        Get.to(() => const VerificationPageView(
              newUser: true,
            ));
      } else {
        context.loaderOverlay.hide();
        Services().getSnackMessage(title: 'Error', message: decodedData['message']);
      }
    });
  }

  ///verification page
  //Forget
  var canResendOtp = false.obs;
  var timer = 0.obs;
  var showResetPasswordField = false.obs;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  TextEditingController setNewPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  sendOtp(BuildContext context, String phone) async {
    context.loaderOverlay.show();
    authProvider.verifyNumber(phone).then((response) async {
      isClicked.value = true;
      context.loaderOverlay.hide();
      // print(jsonDecode(await response.stream.bytesToString()));
      if (response.statusCode == 200) {
        print('truin');
        showResetPasswordField.value = true;
        countDown();
        return ScaffoldMessenger(child: Text('otp sent sucessfully'));
      }
    });
  }

  Future<int> countDown() async {
    canResendOtp.value = false;
    for (timer.value = 0; timer.value <= 30; timer.value++) {
      print(timer.value);
      await Future.delayed(Duration(seconds: 1), () {});
    }
    if (timer.value >= 29) {
      canResendOtp.value = true;
    }
    return timer.value;
  }

  submitOtp(BuildContext context, String phone, String otp) async {
    context.loaderOverlay.show();
    print(phone);
    print(otp);
    authProvider.submitOtp(phone, otp).then((response) async {
      context.loaderOverlay.hide();
      var decodedData = jsonDecode(await response.stream.bytesToString());
      print(decodedData.toString());
      if (decodedData['status'] == true) {
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
                    Icons.security_update_good_outlined,
                    size: 56,
                    color: AppColors.greyTextColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text16by600(
                    text: 'Success',
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const FooterTextWithCenterAligned(
                    text: 'You created successfully account',
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomSolidButton(
                    buttonText: 'Go To Sign In',
                    onClick: () {
                      Get.offAllNamed("/auth-page");
                    },
                    fontSize: 16,
                  )
                ],
              ),
            ));
      } else {
        context.loaderOverlay.hide();
        Services().getSnackMessage(title: 'Error', message: decodedData['message']);
      }
    });
  }

  setPassword(String password) async {
    if (password.isNotEmpty) {
      await Future.delayed(Duration(seconds: 3), () {});
    }
    Get.to(() => HomeView());
  }

  ///Login With Social
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn().then((value) {
        // UserInfoModel().use = value!.displayName.toString();
        print('----------------------------_googleSignIn--------------');
        // print(UserInfoModel().userName);
        // print(UserInfoModel().userName);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void onInit() {
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
