import 'package:get/get.dart';

import '../controllers/journsal_page_controller.dart';

class JournalPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalPageController>(
      () => JournalPageController(),
    );
  }
}
