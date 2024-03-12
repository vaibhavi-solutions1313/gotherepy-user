import 'package:get/get.dart';

import '../controllers/schedule_calls_page_controller.dart';

class ScheduleCallsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleCallsPageController>(
      () => ScheduleCallsPageController(),
    );
  }
}
