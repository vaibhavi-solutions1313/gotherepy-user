import 'package:get/get.dart';

import '../controllers/counselling_page_controller.dart';

class CounsellingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounsellingPageController>(
      () => CounsellingPageController(),
    );
  }
}
