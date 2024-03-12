import 'package:get/get.dart';

import '../controllers/health_assesment_page_controller.dart';

class HealthAssesmentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthAssesmentPageController>(
      () => HealthAssesmentPageController(),
    );
  }
}
