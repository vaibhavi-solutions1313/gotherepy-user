import 'package:get/get.dart';

import '../controllers/counselors_page_controller.dart';

class CounselorsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounselorsPageController>(
      () => CounselorsPageController(),
    );
  }
}
