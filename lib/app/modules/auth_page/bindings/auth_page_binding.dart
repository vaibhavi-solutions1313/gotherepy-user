import 'package:get/get.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/modules/splash_screen/controllers/splash_screen_controller.dart';

import '../controllers/auth_page_controller.dart';

class AuthPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthPageController>(
      () => AuthPageController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<SplashScreenController>(
          () => SplashScreenController(),
    );
  }
}
