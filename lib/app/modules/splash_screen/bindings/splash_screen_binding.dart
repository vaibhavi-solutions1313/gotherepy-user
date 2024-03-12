import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../schedule_calls_page/controllers/schedule_calls_page_controller.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ScheduleCallsPageController>(
          () => ScheduleCallsPageController(),
    );
  }
}
