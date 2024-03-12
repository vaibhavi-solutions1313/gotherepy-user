import 'package:get/get.dart';

import '../controllers/plan_and_pricing_controller.dart';

class PlanAndPricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanAndPricingController>(
      () => PlanAndPricingController(),
    );
  }
}
