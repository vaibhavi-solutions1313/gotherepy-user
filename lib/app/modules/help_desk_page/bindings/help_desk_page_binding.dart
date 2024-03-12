import 'package:get/get.dart';

import '../controllers/help_desk_page_controller.dart';

class HelpDeskPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpDeskPageController>(
      () => HelpDeskPageController(),
    );
  }
}
