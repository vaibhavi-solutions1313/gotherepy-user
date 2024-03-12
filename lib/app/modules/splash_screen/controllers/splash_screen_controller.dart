import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/modules/home/bindings/home_binding.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/modules/home/views/home_view.dart';
import 'package:gotherepy/app/modules/intro_screen/views/intro_screen_view.dart';
import '../../../../main.dart';
import '../../../app_model/user_info.dart';
import '../../../app_utils/services.dart';
import '../../profile_page/providers/profile_info_provider.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  var opacity = false.obs;

  Future tryAutoLogin() async {
    if (Get.find<Services>().box.hasData('accessToken')) {
      EndPoints.getAccessToken().then((value) async {
        await ProfileInfoProvider().fetchUserInfo();
        userInfo.userData.value=UserInfoModel.fromJson(Get.find<Services>().box.read('userInfo'));
        await getAllData();
        Get.to(() => const HomeView(),binding: HomeBinding());
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.to(() => const IntroScreenView(),binding: HomeBinding());
      });
    }
  }

  Future getAllData() async {
    await Future.wait([
      Get.find<HomeController>().provider.getCounselling(),
      Get.find<HomeController>().provider.fetchBanner(),
      Get.find<HomeController>().provider.fetchDoctorBanner(),
      Get.find<HomeController>().getTherapist(),
    ]);
  }

  @override
  void onInit() {
    super.onInit();

    opacity.value = true;
  }

  @override
  void onReady() async {
    await tryAutoLogin();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
