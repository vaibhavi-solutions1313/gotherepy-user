import 'package:get/get.dart';

import '../../schedule_calls_page/controllers/schedule_calls_page_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ScheduleCallsPageController>(
          () => ScheduleCallsPageController(),
    );
  }
}
