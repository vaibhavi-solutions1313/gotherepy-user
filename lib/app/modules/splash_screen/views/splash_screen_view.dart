import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/app_images.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SplashScreenController splashScreenController=Get.put(SplashScreenController());
    return Scaffold(
      body:  Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
              duration: Duration(seconds: 4),
              opacity: controller.opacity.value?1.0:0.0,
              child: Image.asset(AppImages.appLogoImage1)),
          Center(child: SizedBox(width:50,child: LinearProgressIndicator(minHeight: 2,)))
        ],
      )),
    );
  }
}
